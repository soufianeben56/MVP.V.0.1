import 'dart:convert';

class LoginProfileResponse {
  String? uuid;
  List<String>? permissions;
  List<Branches>? branches;
  bool? isPermissionsDefault;
  String? locale;
  String? email;
  String? phone;
  bool? enabled;
  bool? noAccessToSystem;
  String? name;
  String? fullName;
  bool? createdFromAdmin;
  Company? company;
  Employee? employee;
  CompanyRole? companyRole;
  UserAvatar? avatar;
  num? number;
  bool? sendNotifications;
  bool? sendAnnouncements;

  LoginProfileResponse(
      {this.uuid,
      this.permissions,
      this.branches,
      this.isPermissionsDefault,
      this.locale,
      this.email,
      this.phone,
      this.enabled,
      this.noAccessToSystem,
      this.name,
      this.fullName,
      this.createdFromAdmin,
      this.company,
      this.employee,
      this.companyRole,
      this.number,
      this.avatar,
      this.sendNotifications,
      this.sendAnnouncements});

  LoginProfileResponse.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    permissions =
        json['permissions'] != null ? json['permissions'].cast<String>() : [];
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(Branches.fromJson(v));
      });
    }
    isPermissionsDefault = json['isPermissionsDefault'];
    locale = json['locale'];
    email = json['email'];
    phone = json['phone'];
    enabled = json['enabled'];
    noAccessToSystem = json['noAccessToSystem'];
    name = json['name'];
    fullName = json['fullName'];
    createdFromAdmin = json['createdFromAdmin'];
    avatar =
        json['avatar'] != null ? UserAvatar.fromJson(json['avatar']) : null;
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    employee =
        json['employee'] != null ? Employee.fromJson(json['employee']) : null;
    companyRole = json['companyRole'] != null
        ? CompanyRole.fromJson(json['companyRole'])
        : null;
    number = json['number'];
    sendAnnouncements = json['sendAnnouncements'];
    sendNotifications = json['sendNotifications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['permissions'] = permissions;
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    data['isPermissionsDefault'] = isPermissionsDefault;
    data['locale'] = locale;
    data['email'] = email;
    data['phone'] = phone;
    data['enabled'] = enabled;
    data['noAccessToSystem'] = noAccessToSystem;
    data['name'] = name;
    data['fullName'] = fullName;
    data['createdFromAdmin'] = createdFromAdmin;
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    if (companyRole != null) {
      data['companyRole'] = companyRole!.toJson();
    }
    data['number'] = number;
    data['sendNotifications'] = sendNotifications;
    data['sendAnnouncements'] = sendAnnouncements;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}

class UserAvatar {
  String? uuid;
  String? href;
  String? originName;

  UserAvatar({this.uuid, this.href, this.originName});

  UserAvatar.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    href = json['href'];
    originName = json['originName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['href'] = href;
    data['originName'] = originName;
    return data;
  }
}

class Branches {
  String? uuid;
  Country? country;
  DefaultCurrency? defaultCurrency;
  bool? isCompany;
  Company? company;
  List<String>? pricingModules;
  num? pricingUserLimit;
  num? pricingEmployeeLimit;
  String? nfcID;
  bool? enabled;
  bool? suspended;
  bool? inSystem;
  bool? inSyncSystem;
  String? initialSetupFinishedAt;
  String? migrateDate;
  String? openingBalanceSubmittedAt;
  City? city;
  String? cityZone;
  String? area;
  String? address;
  String? phone;
  String? fax;
  String? email;
  String? locale;
  String? timezone;
  bool? allowAccessFromUnknownDevices;
  bool? allowPerformanceModule;
  bool? allowHiringModule;
  String? name;

  Branches({
    this.uuid,
    this.country,
    this.defaultCurrency,
    this.isCompany,
    this.company,
    this.pricingModules,
    this.pricingUserLimit,
    this.pricingEmployeeLimit,
    this.nfcID,
    this.enabled,
    this.suspended,
    this.inSystem,
    this.inSyncSystem,
    this.initialSetupFinishedAt,
    this.migrateDate,
    this.openingBalanceSubmittedAt,
    this.city,
    this.cityZone,
    this.area,
    this.address,
    this.phone,
    this.fax,
    this.email,
    this.locale,
    this.timezone,
    this.allowAccessFromUnknownDevices,
    this.allowPerformanceModule,
    this.allowHiringModule,
    this.name,
  });

  Branches.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    defaultCurrency = json['defaultCurrency'] != null
        ? DefaultCurrency.fromJson(json['defaultCurrency'])
        : null;
    isCompany = json['isCompany'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    pricingModules = json['pricingModules'] != null
        ? json['pricingModules'].cast<String>()
        : [];
    pricingUserLimit = json['pricingUserLimit'];
    pricingEmployeeLimit = json['pricingEmployeeLimit'];
    nfcID = json['nfcID'];
    enabled = json['enabled'];
    suspended = json['suspended'];
    inSystem = json['inSystem'];
    inSyncSystem = json['inSyncSystem'];
    initialSetupFinishedAt = json['initialSetupFinishedAt'];
    migrateDate = json['migrateDate'];
    openingBalanceSubmittedAt = json['openingBalanceSubmittedAt'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    cityZone = json['cityZone'];
    area = json['area'];
    address = json['address'];
    phone = json['phone'];
    fax = json['fax'];
    email = json['email'];
    locale = json['locale'];
    timezone = json['timezone'];
    allowAccessFromUnknownDevices = json['allowAccessFromUnknownDevices'];
    allowPerformanceModule = json['allowPerformanceModule'];
    allowHiringModule = json['allowHiringModule'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (defaultCurrency != null) {
      data['defaultCurrency'] = defaultCurrency!.toJson();
    }
    data['isCompany'] = isCompany;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['pricingModules'] = pricingModules;
    data['pricingUserLimit'] = pricingUserLimit;
    data['pricingEmployeeLimit'] = pricingEmployeeLimit;
    data['nfcID'] = nfcID;
    data['enabled'] = enabled;
    data['suspended'] = suspended;
    data['inSystem'] = inSystem;
    data['inSyncSystem'] = inSyncSystem;
    data['initialSetupFinishedAt'] = initialSetupFinishedAt;
    data['migrateDate'] = migrateDate;
    data['openingBalanceSubmittedAt'] = openingBalanceSubmittedAt;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['cityZone'] = cityZone;
    data['area'] = area;
    data['address'] = address;
    data['phone'] = phone;
    data['fax'] = fax;
    data['email'] = email;
    data['locale'] = locale;
    data['timezone'] = timezone;
    data['allowAccessFromUnknownDevices'] = allowAccessFromUnknownDevices;
    data['allowPerformanceModule'] = allowPerformanceModule;
    data['allowHiringModule'] = allowHiringModule;
    data['name'] = name;
    return data;
  }
}

class Country {
  String? uuid;
  String? name;
  String? code;

  Country({
    this.uuid,
    this.name,
    this.code,
  });

  Country.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}

class DefaultCurrency {
  String? uuid;
  String? code;
  List<String>? banknotes;
  bool? isDefault;
  String? name;

  DefaultCurrency({
    this.uuid,
    this.code,
    this.banknotes,
    this.isDefault,
    this.name,
  });

  DefaultCurrency.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    code = json['code'];
    banknotes =
        json['banknotes'] != null ? json['banknotes'].cast<String>() : [];
    isDefault = json['isDefault'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['code'] = code;
    data['banknotes'] = banknotes;
    data['isDefault'] = isDefault;
    data['name'] = name;
    return data;
  }
}

class City {
  String? uuid;
  Country? country;
  String? name;
  String? code;

  City({
    this.uuid,
    this.country,
    this.name,
    this.code,
  });

  City.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}

class Company {
  String? uuid;
  Country? country;
  DefaultCurrency? defaultCurrency;
  bool? isCompany;
  Company? company;
  List<String>? pricingModules;
  num? pricingUserLimit;
  num? pricingEmployeeLimit;
  String? nfcID;
  bool? enabled;
  bool? suspended;
  bool? inSystem;
  bool? inSyncSystem;
  String? initialSetupFinishedAt;
  String? migrateDate;
  City? city;
  String? cityZone;
  String? area;
  String? address;
  String? phone;
  String? fax;
  String? email;
  String? locale;
  Logo? logo;
  String? timezone;
  bool? allowAccessFromUnknownDevices;
  bool? allowPerformanceModule;
  bool? allowHiringModule;
  String? name;

  Company({
    this.uuid,
    this.country,
    this.defaultCurrency,
    this.isCompany,
    this.company,
    this.pricingModules,
    this.pricingUserLimit,
    this.pricingEmployeeLimit,
    this.nfcID,
    this.enabled,
    this.suspended,
    this.inSystem,
    this.inSyncSystem,
    this.initialSetupFinishedAt,
    this.migrateDate,
    this.city,
    this.cityZone,
    this.area,
    this.address,
    this.phone,
    this.fax,
    this.email,
    this.locale,
    this.logo,
    this.timezone,
    this.allowAccessFromUnknownDevices,
    this.allowPerformanceModule,
    this.allowHiringModule,
    this.name,
  });

  Company.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    defaultCurrency = json['defaultCurrency'] != null
        ? DefaultCurrency.fromJson(json['defaultCurrency'])
        : null;
    isCompany = json['isCompany'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    pricingModules = json['pricingModules'] != null
        ? json['pricingModules'].cast<String>()
        : [];
    pricingUserLimit = json['pricingUserLimit'];
    pricingEmployeeLimit = json['pricingEmployeeLimit'];
    nfcID = json['nfcID'];
    enabled = json['enabled'];
    suspended = json['suspended'];
    inSystem = json['inSystem'];
    inSyncSystem = json['inSyncSystem'];
    initialSetupFinishedAt = json['initialSetupFinishedAt'];
    migrateDate = json['migrateDate'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    cityZone = json['cityZone'];
    area = json['area'];
    address = json['address'];
    phone = json['phone'];
    fax = json['fax'];
    email = json['email'];
    locale = json['locale'];
    logo = json['logo'] != null ? Logo.fromJson(json['logo']) : null;
    timezone = json['timezone'];
    allowAccessFromUnknownDevices = json['allowAccessFromUnknownDevices'];
    allowPerformanceModule = json['allowPerformanceModule'];
    allowHiringModule = json['allowHiringModule'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (defaultCurrency != null) {
      data['defaultCurrency'] = defaultCurrency!.toJson();
    }
    data['isCompany'] = isCompany;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['pricingModules'] = pricingModules;
    data['pricingUserLimit'] = pricingUserLimit;
    data['pricingEmployeeLimit'] = pricingEmployeeLimit;
    data['nfcID'] = nfcID;
    data['enabled'] = enabled;
    data['suspended'] = suspended;
    data['inSystem'] = inSystem;
    data['inSyncSystem'] = inSyncSystem;
    data['initialSetupFinishedAt'] = initialSetupFinishedAt;
    data['migrateDate'] = migrateDate;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['cityZone'] = cityZone;
    data['area'] = area;
    data['address'] = address;
    data['phone'] = phone;
    data['fax'] = fax;
    data['email'] = email;
    data['locale'] = locale;
    if (logo != null) {
      data['logo'] = logo!.toJson();
    }
    data['timezone'] = timezone;
    data['allowAccessFromUnknownDevices'] = allowAccessFromUnknownDevices;
    data['allowPerformanceModule'] = allowPerformanceModule;
    data['allowHiringModule'] = allowHiringModule;
    data['name'] = name;
    return data;
  }
}

class Logo {
  String? uuid;
  String? href;
  String? originName;

  Logo({this.uuid, this.href, this.originName});

  Logo.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    href = json['href'];
    originName = json['originName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['href'] = href;
    data['originName'] = originName;
    return data;
  }
}

class Employee {
  String? uuid;
  Country? manager;
  bool? hasSubordinates;
  bool? isManager;
  bool? isApprover;
  Country? topEmployee;
  Company? branch;
  num? employeeID;
  String? employeeNumber;
  String? fingerPrintId;
  Department? department;
  Title? title;
  String? startDate;
  String? name;
  String? email;
  String? phone;
  String? birthDate;
  String? maritalStatus;
  String? gender;
  City? city;
  String? address;
  String? deviceID;
  String? identificationType;
  String? identificationNumber;
  String? identificationIssueDate;
  String? identificationExpirationDate;
  String? emergencyContactName;
  String? emergencyContactPhone;
  bool? timeTrackingEnabled;
  CompensationPolicy? compensationPolicy;
  bool? isLaidOff;
  String? healthInsuranceType;
  Country? division;
  String? workEmail;
  bool? hasChildren;
  num? numberOfChildren;
  Logo? personalPhoto;
  String? zktecoId;
  bool? isActive;
  bool? isReady;

  Employee({
    this.uuid,
    this.manager,
    this.hasSubordinates,
    this.isManager,
    this.isApprover,
    this.topEmployee,
    this.branch,
    this.employeeID,
    this.employeeNumber,
    this.fingerPrintId,
    this.department,
    this.title,
    this.startDate,
    this.name,
    this.email,
    this.phone,
    this.birthDate,
    this.maritalStatus,
    this.gender,
    this.city,
    this.address,
    this.deviceID,
    this.identificationType,
    this.identificationNumber,
    this.identificationIssueDate,
    this.identificationExpirationDate,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.timeTrackingEnabled,
    this.compensationPolicy,
    this.isLaidOff,
    this.healthInsuranceType,
    this.division,
    this.workEmail,
    this.hasChildren,
    this.numberOfChildren,
    this.personalPhoto,
    this.zktecoId,
    this.isActive,
    this.isReady,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    manager =
        json['manager'] != null ? Country.fromJson(json['manager']) : null;
    hasSubordinates = json['hasSubordinates'];
    isManager = json['isManager'];
    isApprover = json['isApprover'];
    topEmployee = json['topEmployee'] != null
        ? Country.fromJson(json['topEmployee'])
        : null;
    branch = json['branch'] != null ? Company.fromJson(json['branch']) : null;
    employeeID = json['employeeID'];
    employeeNumber = json['employeeNumber'];
    fingerPrintId = json['fingerPrintId'];
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    startDate = json['startDate'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    birthDate = json['birthDate'];
    maritalStatus = json['maritalStatus'];
    gender = json['gender'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    address = json['address'];
    deviceID = json['deviceID'];
    identificationType = json['identificationType'];
    identificationNumber = json['identificationNumber'];
    identificationIssueDate = json['identificationIssueDate'];
    identificationExpirationDate = json['identificationExpirationDate'];
    emergencyContactName = json['emergencyContactName'];
    emergencyContactPhone = json['emergencyContactPhone'];
    timeTrackingEnabled = json['timeTrackingEnabled'];
    compensationPolicy = json['compensationPolicy'] != null
        ? CompensationPolicy.fromJson(json['compensationPolicy'])
        : null;
    isLaidOff = json['isLaidOff'];
    healthInsuranceType = json['healthInsuranceType'];
    division =
        json['division'] != null ? Country.fromJson(json['division']) : null;
    workEmail = json['workEmail'];
    hasChildren = json['hasChildren'];
    numberOfChildren = json['numberOfChildren'];
    personalPhoto = json['personalPhoto'] != null
        ? Logo.fromJson(json['personalPhoto'])
        : null;
    zktecoId = json['zktecoId'];
    isActive = json['isActive'];
    isReady = json['isReady'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    if (manager != null) {
      data['manager'] = manager!.toJson();
    }
    data['hasSubordinates'] = hasSubordinates;
    data['isManager'] = isManager;
    data['isApprover'] = isApprover;
    if (topEmployee != null) {
      data['topEmployee'] = topEmployee!.toJson();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    data['employeeID'] = employeeID;
    data['employeeNumber'] = employeeNumber;
    data['fingerPrintId'] = fingerPrintId;
    if (department != null) {
      data['department'] = department!.toJson();
    }
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['startDate'] = startDate;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['birthDate'] = birthDate;
    data['maritalStatus'] = maritalStatus;
    data['gender'] = gender;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['address'] = address;
    data['deviceID'] = deviceID;
    data['identificationType'] = identificationType;
    data['identificationNumber'] = identificationNumber;
    data['identificationIssueDate'] = identificationIssueDate;
    data['identificationExpirationDate'] = identificationExpirationDate;
    data['emergencyContactName'] = emergencyContactName;
    data['emergencyContactPhone'] = emergencyContactPhone;
    data['timeTrackingEnabled'] = timeTrackingEnabled;
    if (compensationPolicy != null) {
      data['compensationPolicy'] = compensationPolicy!.toJson();
    }
    data['isLaidOff'] = isLaidOff;
    data['healthInsuranceType'] = healthInsuranceType;
    if (division != null) {
      data['division'] = division!.toJson();
    }
    data['workEmail'] = workEmail;
    data['hasChildren'] = hasChildren;
    data['numberOfChildren'] = numberOfChildren;
    if (personalPhoto != null) {
      data['personalPhoto'] = personalPhoto!.toJson();
    }
    data['zktecoId'] = zktecoId;
    data['isActive'] = isActive;
    data['isReady'] = isReady;
    return data;
  }
}

class Department {
  String? uuid;
  Country? division;
  Country? director;
  List<Employees>? employees;
  bool? isDefault;
  String? name;

  Department({
    this.uuid,
    this.division,
    this.director,
    this.employees,
    this.isDefault,
    this.name,
  });

  Department.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    division =
        json['division'] != null ? Country.fromJson(json['division']) : null;
    director =
        json['director'] != null ? Country.fromJson(json['director']) : null;
    if (json['employees'] != null) {
      employees = <Employees>[];
      json['employees'].forEach((v) {
        employees!.add(Employees.fromJson(v));
      });
    }
    isDefault = json['isDefault'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    if (division != null) {
      data['division'] = division!.toJson();
    }
    if (director != null) {
      data['director'] = director!.toJson();
    }
    if (employees != null) {
      data['employees'] = employees!.map((v) => v.toJson()).toList();
    }
    data['isDefault'] = isDefault;
    data['name'] = name;
    return data;
  }
}

class Employees {
  String? id;
  String? name;

  Employees({
    this.id,
    this.name,
  });

  Employees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Title {
  String? uuid;
  List<Employees>? employees;
  bool? isDefault;
  String? name;

  Title({
    this.uuid,
    this.employees,
    this.isDefault,
    this.name,
  });

  Title.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    if (json['employees'] != null) {
      employees = <Employees>[];
      json['employees'].forEach((v) {
        employees!.add(Employees.fromJson(v));
      });
    }
    isDefault = json['isDefault'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    if (employees != null) {
      data['employees'] = employees!.map((v) => v.toJson()).toList();
    }
    data['isDefault'] = isDefault;
    data['name'] = name;
    return data;
  }
}

class Type {
  String? uuid;
  String? type;
  bool? useAsDefault;
  String? slug;
  bool? isDefault;
  bool? isActive;
  String? name;

  Type({
    this.uuid,
    this.type,
    this.useAsDefault,
    this.slug,
    this.isDefault,
    this.isActive,
    this.name,
  });

  Type.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    type = json['type'];
    useAsDefault = json['useAsDefault'];
    slug = json['slug'];
    isDefault = json['isDefault'];
    isActive = json['isActive'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['type'] = type;
    data['useAsDefault'] = useAsDefault;
    data['slug'] = slug;
    data['isDefault'] = isDefault;
    data['isActive'] = isActive;
    data['name'] = name;
    return data;
  }
}

class CompensationPolicy {
  String? uuid;
  num? principalSalary;
  num? ratePerDay;
  num? ratePerHour;
  num? ratePerHourOvertime;
  num? loanMonthlyPayment;
  bool? isChanged;

  CompensationPolicy({
    this.uuid,
    this.principalSalary,
    this.ratePerDay,
    this.ratePerHour,
    this.ratePerHourOvertime,
    this.loanMonthlyPayment,
    this.isChanged,
  });

  CompensationPolicy.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    principalSalary = json['principalSalary'];
    ratePerDay = json['ratePerDay'];
    ratePerHour = json['ratePerHour'];
    ratePerHourOvertime = json['ratePerHourOvertime'];
    loanMonthlyPayment = json['loanMonthlyPayment'];
    isChanged = json['isChanged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['principalSalary'] = principalSalary;
    data['ratePerDay'] = ratePerDay;
    data['ratePerHour'] = ratePerHour;
    data['ratePerHourOvertime'] = ratePerHourOvertime;
    data['loanMonthlyPayment'] = loanMonthlyPayment;
    data['isChanged'] = isChanged;
    return data;
  }
}

class Division {
  String? uuid;
  bool? isDefault;
  String? name;

  Division({
    this.uuid,
    this.isDefault,
    this.name,
  });

  Division.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    isDefault = json['isDefault'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['isDefault'] = isDefault;
    data['name'] = name;
    return data;
  }
}

class CompanyRole {
  String? uuid;
  List<CompanyRoleUsers>? users;
  List<String>? permissions;
  bool? isDefault;
  String? name;

  CompanyRole({
    this.uuid,
    this.users,
    this.permissions,
    this.isDefault,
    this.name,
  });

  CompanyRole.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    if (json['users'] != null) {
      users = <CompanyRoleUsers>[];
      json['users'].forEach((v) {
        users!.add(CompanyRoleUsers.fromJson(v));
      });
    }
    permissions =
        json['permissions'] != null ? json['permissions'].cast<String>() : [];
    isDefault = json['isDefault'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    data['permissions'] = permissions;
    data['isDefault'] = isDefault;
    data['name'] = name;
    return data;
  }
}

class CompanyRoleUsers {
  String? id;
  String? name;

  CompanyRoleUsers({
    this.id,
    this.name,
  });

  CompanyRoleUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
