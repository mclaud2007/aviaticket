//
//  AirportListController.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "AirportListController.h"

@interface AirportListController ()

@property Airport *selectedAirport;

@end

@implementation AirportListController

- (instancetype)initWithCity:(City *)city AndCountry:(Country *)country {
    self = [super init];
    
    self.selectedCountry = country;
    self.selectedCity = city;
    self.airports = [NSMutableArray array];
    
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    _datePicker.minimumDate = [NSDate date];
    
    _dateTextField = [[UITextField alloc] initWithFrame:self.view.bounds];
    _dateTextField.hidden = YES;
    _dateTextField.inputView = _datePicker;
    
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidTap)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    
    _dateTextField.inputAccessoryView = keyboardToolbar;
    [self.view addSubview:_dateTextField];
    
    return self;
}

- (void)doneButtonDidTap
{
    if (_datePicker.date && _selectedAirport) {
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"reminderText", @""), _selectedAirport.name];
        Notification notification = NotificationMake(NSLocalizedString(@"reminderTextTitle", @""), message, _datePicker.date, nil);
        [[NotificationCenter shared] sendNotification:notification];

        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"remindMakeDoneTitle", @"") message:[NSString stringWithFormat:NSLocalizedString(@"remindWillSendMessage", @""), _datePicker.date] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"close", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.view endEditing:YES];
            [self.dateTextField resignFirstResponder];
        }];

        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }

    _datePicker.date = [NSDate date];
    _selectedAirport = nil;

    [self.view endEditing:YES];
    [self.dateTextField resignFirstResponder];
}

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view = [[AirportListView alloc] initWithFrame:frame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.selectedCity.name;
    
    AirportListView *view = (AirportListView *) self.view;
    self.tableView = view.tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:AirportCell.self forCellReuseIdentifier:@"AirportCell"];
    
    // Фильтруем аэропорты по городу и стране
    [self loadAirportByCountry:self.selectedCountry AndCity:self.selectedCity];
    
    // Изображение информация
    UIImage *infoImage = [UIImage systemImageNamed:@"info.circle"];
    
    // Добавляем кнопку отображения информации о текущей стране
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:infoImage style:UIBarButtonItemStylePlain target:self action:NSSelectorFromString(@"getCountryInfo")];
    
}

- (void)getCountryInfo {
    MapController  *mapController = [[MapController alloc] init];
    mapController.modalPresentationStyle = UIModalPresentationPopover;
    mapController.city = self.selectedCity;
    mapController.airports = self.airports;
    
    [self presentViewController:mapController animated:true completion:nil];
}

- (void)loadAirportByCountry:(Country *)country AndCity:(City *)city {
    NSArray *dataAirports = [DataManager sharedInstance].airports;
    
    for (NSUInteger i = 0; i < [dataAirports count]; i++) {
        Airport *testAirport = [dataAirports objectAtIndex:i];
        
        if (testAirport.countryCode == country.code && testAirport.cityCode == city.code) {
            [self.airports addObject:testAirport];
        }
    }
}

// MARK: TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.airports count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AirportCell *cell = (AirportCell *) [self.tableView dequeueReusableCellWithIdentifier:@"AirportCell"];

    // Аэропорт который нужно показать
    Airport *airport = [self.airports objectAtIndex:indexPath.row];

    // Настраиваем внешний вид ячейки
    [cell configureWith:airport];

    return cell;
}

// MARK: TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Аэропорт который выбрали
    _selectedAirport = [self.airports objectAtIndex:indexPath.row];
    
    NSString *_selectedAirportName = _selectedAirport.name;
    NSLocale *local = [NSLocale currentLocale];
    NSString *localeID = [local.localeIdentifier substringToIndex:2];
    NSDictionary *_translations = _selectedAirport.translations;
    
    if (localeID) {
        if ([_translations valueForKey:localeID]) {
            _selectedAirportName = [_translations valueForKey:localeID];
        }
    }
     
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"airportTitle", @"") message:[NSString stringWithFormat:NSLocalizedString(@"youChose", @""), _selectedAirportName] preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"remindTitle", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dateTextField becomeFirstResponder];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Close", @"") style:UIAlertActionStyleCancel handler:nil];
    
    [alertVC addAction:notificationAction];
    [alertVC addAction:cancelAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
