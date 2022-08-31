# Turkce karakterlerden cozumde kacinilmistir
# Hamburgerci için diyet R çözümü 
# Import lpSolve package
# lpsolve paketi yuklenmediyse asagidaki 
# install.packages("lpSolve")
library(lpSolve)

# Set coefficients of the objective function
# Amac fonksiyonunun katsayilari
# z=1H+3B+2.5M+3S+1P ==> 1,3,2.5,3,1 
f.obj <- c(1, 3, 2.5, 3, 1, 0) # 1H+3B+2.5M+3S+1P+0F

# Set matrix corresponding to coefficients of constraints by rows
# Kalori icin yeni bir degisken ekleyip onu F ile gostermistik
# Sutunlar sirasiyla, H, B, M, S, R ve son sutun F 
f.con <- matrix(c(250, 770, 360, 190, 230, -1,   # Kalori <= 900 ve >=600 
                  81, 360, 144, 45, 99, -0.4,    # Kalori Yag %40
                  480, 1170, 800, 580, 160, 0,   # Sodyum
                  31, 44, 14, 27, 3, 0,          # Protein
                  0, 0, 0, 0, 0, 1,              # Kalori >= 600  
                  0, 0, 0, 0, 0, 1),             # Kalori <= 900
                nrow = 6, byrow = TRUE)

# <=, >= veya == olmali kisitlar
f.dir <- c("==",
           "<=",
           "<=",
           ">=",
           ">=",
           "<=")

# Kisitlarin sag taraflari
f.rhs <- c(0,
           0,
           1150,
           30,
           600,
           900)

# DP cozumu
z_lp <- lp(direction = "min",    # Min maliyet
           objective.in = f.obj, # Amac Fonks. 
           const.mat = f.con,    # Kisit Matrisi
           const.dir = f.dir,    # Kisitlarin yonu
           const.rhs = f.rhs)    # Kisitlarin sag tarafi

# Tam Sayi Programlama Cozumu
z_ip <- lp(direction = "min", 
           objective.in = f.obj, 
           const.mat = f.con, 
           const.dir = f.dir, 
           const.rhs = f.rhs, 
           all.int = T)

# Cozum Sonuclari 
# Cozum hakkinda kisa bilgi
z_lp

# Cozumun Sonucu degerler 
# sirasiyla, H, B, M, S, R ve F
z_lp$solution

# daha guzel gosterim icin
lp_sl <- matrix(round(z_lp$solution, 2), ncol=1, nrow = 6)   
rownames(lp_sl) <- c("H", "B", "M", "S", "R", "F")
lp_sl

# Tam Sayi Cozumu sonuclari
# TP sonucu hakkinda kisa bilgi
z_ip

# Cozumun Sonucu degerler 
ip_sl <- matrix(round(z_ip$solution), ncol=1, nrow = 6)   
rownames(ip_sl) <- c("H", "B", "M", "S", "R", "F")
ip_sl
