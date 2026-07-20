//للتذكير هاد  كلاس بيحوي كل خطأ ممكن يصير لنتعامل معه بغير مكان 


abstract class APIError {}

// ignore: camel_case_types
class NO_INTERNET extends APIError {}

// ignore: camel_case_types
class SEND_TIMEOUT extends NO_INTERNET {}

// ignore: camel_case_types
class RECIEVE_TIMEOUT extends NO_INTERNET {}

class CANCELED extends APIError {}

// ignore: camel_case_types
class SERVER_ERROR extends APIError {}

// ignore: camel_case_types
class VALIDATION_ERROR extends APIError {}

// ignore: camel_case_types
class UN_AUTHORIZED extends APIError {}

class FORBIDDEN extends APIError {}

class ModellingError extends APIError {}

// ignore: camel_case_types
class NO_CONTENT extends APIError {}

class OTHER extends APIError {}