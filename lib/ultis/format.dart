class Format{
  double formatDurationToInt(String duration){
    String minute = duration.split(':')[0];
    String second = duration.split(':')[1];
    return double.parse(minute)*60 + double.parse(second);
  }

  String formatIntToDuration (double seconds){

    int minutes = seconds ~/ 60; // Lấy số phút
    int remainingSeconds = (seconds % 60).toInt(); // Lấy phần giây và chuyển về kiểu int

    // Trả về chuỗi theo định dạng "phút:giây", với giây luôn có 2 chữ số
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';

  }
}