<?php
    require 'assets/partials/_functions.php';
    $conn = db_connect();    

    if(!$conn) 
        die("Connection Failed");
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bus Pro</title>
    <!-- google fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500&display=swap" rel="stylesheet">
    <!-- Font-awesome -->
    <script src="https://kit.fontawesome.com/d8cfbe84b9.js" crossorigin="anonymous"></script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <!-- CSS -->
    <?php 
        require 'assets/styles/styles.php'
    ?>
</head>
<body>
    <?php
    
    if(isset($_GET["booking_added"]) && !isset($_POST['pnr-search']))
    {
        if($_GET["booking_added"])
        {
            echo '<div class="my-0 alert alert-success alert-dismissible fade show" role="alert">
                <strong>Successful!</strong> Booking Added, your PNR is <span style="font-weight:bold; color: #272640;">'. $_GET["pnr"] .'</span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>';
        }
        else{
            // Show error alert
            echo '<div class="my-0 alert alert-danger alert-dismissible fade show" role="alert">
            <strong>Error!</strong> Booking already exists
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>';
        }
    }

    if($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["pnr-search"]))
    {
        $pnr = $_POST["pnr"];

        $sql = "SELECT * FROM bookings WHERE booking_id='$pnr'";
        $result = mysqli_query($conn, $sql);

        $num = mysqli_num_rows($result);

        if($num)
        {
            $row = mysqli_fetch_assoc($result);
            $route_id = $row["route_id"];
            $customer_id = $row["customer_id"];
            
            $customer_name = get_from_table($conn, "customers", "customer_id", $customer_id, "customer_name");

            $customer_phone = get_from_table($conn, "customers", "customer_id", $customer_id, "customer_phone");

            $customer_route = $row["customer_route"];
            $booked_amount = $row["booked_amount"];

            $booked_seat = $row["booked_seat"];
            $booked_timing = $row["booking_created"];
 
            $dep_date = get_from_table($conn, "routes", "route_id", $route_id, "route_dep_date");

            $dep_time = get_from_table($conn, "routes", "route_id", $route_id, "route_dep_time");

            $bus_no = get_from_table($conn, "routes", "route_id", $route_id, "bus_no");
            ?>

            <div class="alert alert-dark alert-dismissible fade show" role="alert">
            
            <h4 class="alert-heading">Thông tin về đặt vé!</h4>
            <p>
                <button class="btn btn-sm btn-success"><a href="assets/partials/_download.php?pnr=<?php echo $pnr; ?>" class="link-light">Tải xuống</a></button>
                <button class="btn btn-danger btn-sm" id="deleteBooking" data-bs-toggle="modal" data-bs-target="#deleteModal" data-pnr="<?php echo $pnr;?>" data-seat="<?php echo $booked_seat;?>" data-bus="<?php echo $bus_no; ?>">
                    Xóa
                </button>
            </p>
            <hr>
                <p class="mb-0">
                    <ul class="pnr-details">
                        <li>
                            <strong>PNR : </strong>
                            <?php echo $pnr; ?>
                        </li>
                        <li>
                            <strong>Tên khách hàng : </strong>
                            <?php echo $customer_name; ?>
                        </li>
                        <li>
                            <strong>Điện thoại khách hàng : </strong>
                            <?php echo $customer_phone; ?>
                        </li>
                        <li>
                            <strong>Tuyến đường : </strong>
                            <?php echo $customer_route; ?>
                        </li>
                        <li>
                            <strong>Số xe buýt : </strong>
                            <?php echo $bus_no; ?>
                        </li>
                        <li>
                            <strong>Số chỗ đã đặt : </strong>
                            <?php echo $booked_seat; ?>
                        </li>
                        <li>
                            <strong>Ngày khởi hành : </strong>
                            <?php echo $dep_date; ?>
                        </li>
                        <li>
                            <strong>Giờ khởi hành : </strong>
                            <?php echo $dep_time; ?>
                        </li>
                        <li>
                            <strong>Thời gian đã đặt : </strong>
                            <?php echo $booked_timing; ?>
                        </li>

                </p>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php }
        else{
            echo '<div class="my-0 alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Lỗi!</strong> Bản ghi không tồn tại
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>';
        }
        
    ?>
        
    <?php }


        // Delete Booking
        if($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["deleteBtn"]))
        {
            $pnr = $_POST["id"];
            $bus_no = $_POST["bus"];
            $booked_seat = $_POST["booked_seat"];

            $deleteSql = "DELETE FROM `bookings` WHERE `bookings`.`booking_id` = '$pnr'";

                $deleteResult = mysqli_query($conn, $deleteSql);
                $rowsAffected = mysqli_affected_rows($conn);
                $messageStatus = "danger";
                $messageInfo = "";
                $messageHeading = "Error!";

                if(!$rowsAffected)
                {
                    $messageInfo = "Record Doesn't Exist";
                }

                elseif($deleteResult)
                {   
                    $messageStatus = "success";
                    $messageInfo = "Booking Details deleted";
                    $messageHeading = "Successfull!";

                    // Update the Seats table
                    $seats = get_from_table($conn, "seats", "bus_no", $bus_no, "seat_booked");

                    // Extract the seat no. that needs to be deleted
                    $booked_seat = $_POST["booked_seat"];

                    $seats = explode(",", $seats);
                    $idx = array_search($booked_seat, $seats);
                    array_splice($seats,$idx,1);
                    $seats = implode(",", $seats);

                    $updateSeatSql = "UPDATE `seats` SET `seat_booked` = '$seats' WHERE `seats`.`bus_no` = '$bus_no';";
                    mysqli_query($conn, $updateSeatSql);
                }
                else{

                    $messageInfo = "Your request could not be processed due to technical Issues from our part. We regret the inconvenience caused";
                }

                // Message
                echo '<div class="my-0 alert alert-'.$messageStatus.' alert-dismissible fade show" role="alert">
                <strong>'.$messageHeading.'</strong> '.$messageInfo.'
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>';
            }
    ?>

    
    <header>
        <nav>
            <div>
                    <a href="#" class="nav-item nav-logo">BUSPRO</a>
                    <!-- <a href="#" class="nav-item">Gallery</a> -->
            </div>
                
            <ul>
                <li><a href="#" class="nav-item">Trang Chủ</a></li>
                <li><a href="#about" class="nav-item">Giới Thiệu</a></li>
                <li><a href="#contact" class="nav-item">Liên Hệ</a></li>
            </ul>
            <div>
                <a href="#" class="login nav-item" data-bs-toggle="modal" data-bs-target="#loginModal"><i class="fas fa-sign-in-alt" style="margin-right: 0.4rem;"></i>Đăng nhập</a>
                <a href="#pnr-enquiry" class="pnr nav-item">Tải thông tin vé</a>
            </div>
        </nav>
    </header>
    <!-- Login Modal -->
    <?php require 'assets/partials/_loginModal.php'; 
        require 'assets/partials/_getJSON.php';

        $routeData = json_decode($routeJson);
        $busData = json_decode($busJson);
        $customerData = json_decode($customerJson);
    ?>
    

    <section id="home">
        <div id="route-search-form">
            <h1>Hệ thống đặt vé xe buýt</h1>    

            <p class="text-center">Chào mừng bạn đến với Hệ thống đặt vé xe buýt. Đăng nhập ngay để quản lý vé xe buýt và nhiều hơn nữa. HOẶC, chỉ cần cuộn xuống để kiểm tra trạng thái Vé bằng Bản ghi tên hành khách (số PNR)</p>

            <center>
                <button class="btn btn-danger " data-bs-toggle="modal" data-bs-target="#loginModal">Đăng nhập với quản trị viên</button>
                
            </center>

            <br>
            
        </div>
    </section>
    <div id="block">
        <section id="info-num">
            <figure>
                <img src="assets/img/route.svg" alt="Bus Route Icon" width="100px" height="100px">
                <figcaption>
                    <span class="num counter" data-target="<?php echo count($routeData); ?>">999</span>
                    <span class="icon-name">Tuyến đường</span>
                </figcaption>
            </figure>
            <figure>
                <img src="assets/img/bus.svg" alt="Bus Icon" width="100px" height="100px">
                <figcaption>
                    <span class="num counter" data-target="<?php echo count($busData); ?>">999</span>
                    <span class="icon-name">Xe Buýt</span>
                </figcaption>
            </figure>
            <figure>
                <img src="assets/img/customer.svg" alt="Happy Customer Icon" width="100px" height="100px">
                <figcaption>
                    <span class="num counter" data-target="<?php echo count($customerData); ?>">999</span>
                    <span class="icon-name">Đánh giá</span>
                </figcaption>
            </figure>
            <figure>
                <img src="assets/img/ticket.svg" alt="Instant Ticket Icon" width="100px" height="100px">
                <figcaption>
                    <span class="num"><span class="counter" data-target="20">999</span> SEC</span> 
                    <span class="icon-name">Vé ngay lập tức</span>
                </figcaption>
            </figure>
        </section>
        <section id="pnr-enquiry">
            <div id="pnr-form">
                <h2>Nhập mã PNR </h2>
                <form action="<?php echo $_SERVER["REQUEST_URI"]; ?>" method="POST">
                    <div>
                        <input type="text" name="pnr" id="pnr" placeholder="Nhập PNR">
                    </div>
                    <button type="submit" name="pnr-search">Nộp</button>
                </form>
            </div>
        </section>
        <section id="about">
            <div>
                <h1>Về chúng tôi</h1>
                <h4>Chào mừng bạn đến với BusPro</h4>
                <p>
                Chúng tôi là một đội ngũ đam mê với mục tiêu mang đến trải nghiệm đi lại thuận tiện và hiệu quả cho mọi người. Với sứ mệnh làm cho việc đi lại trở nên dễ dàng hơn bằng cách cung cấp dịch vụ đặt vé xe buýt tiện lợi và đáng tin cậy, chúng tôi luôn nỗ lực không ngừng để cải thiện và phát triển.
                </p>
            </div>
        </section>
        <section id="contact">
            <div id="contact-form">
                <h1>Liên hệ chúng tôi</h1>
                <form action="">
                    <div>
                        <label for="name">Tên</label>
                        <input type="text" name="name" id="name">
                    </div>
                    <div>
                        <label for="email">Email</label>
                        <input type="email" name="email" id="email">
                    </div>
                    <div>
                        <label for="message">Nội dung</label>
                        <textarea name="message" id="message" cols="30" rows="10"></textarea>
                    </div>
                    <div></div>
                </form>
            </div>
        </section>
        <footer>
        <p>
                        <i class="far fa-copyright"></i> <?php echo date('Y');?> - Hệ thống đặt vé xe buýt | BusPro
                        </p>
        </footer>
    </div>
    
    <!-- Delete Booking Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><i class="fas fa-exclamation-circle"></i></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
            <h2 class="text-center pb-4">
            Bạn có chắc không?
            </h2>
            <p>
            Bạn có thực sự muốn xóa? <strong></strong>
            </p>
            <!-- Needed to pass pnr -->
            <form action="<?php echo $_SERVER['PHP_SELF']; ?>" id="delete-form"  method="POST">
                    <input id="delete-id" type="hidden" name="id">
                    <input id="delete-booked-seat" type="hidden" name="booked_seat">
                    <input id="delete-booked-bus" type="hidden" name="bus">
            </form>
      </div>
      <div class="modal-footer">
        <button type="submit" form="delete-form" class="btn btn-primary btn-danger" name="deleteBtn">Xóa</button>
      </div>
    </div>
  </div>
</div>
     <!-- Option 1: Bootstrap Bundle with Popper -->
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
    <!-- External JS -->
    <script src="assets/scripts/main.js"></script>
</body>
</html>