
[1mFrom:[0m /home/ec2-user/environment/bookers2/app/controllers/searches_controller.rb:10 SearchesController#search:

     [1;34m3[0m: [32mdef[0m [1;34msearch[0m
     [1;34m4[0m:   @keyword = params[[33m:keyword[0m]
     [1;34m5[0m:   @table = params[[33m:table[0m]
     [1;34m6[0m:   @match = params[[33m:match[0m]
     [1;34m7[0m: 
     [1;34m8[0m:   binding.pry
     [1;34m9[0m: 
 => [1;34m10[0m:   [32mif[0m @table == [31m[1;31m"[0m[31mUser[1;31m"[0m[31m[0m
    [1;34m11[0m:     @users = [1;34;4mUser[0m.search(@keyword)
    [1;34m12[0m:     render [31m[1;31m"[0m[31musers/index[1;31m"[0m[31m[0m
    [1;34m13[0m: 
    [1;34m14[0m:   [32melsif[0m @table == [31m[1;31m"[0m[31mBook[1;31m"[0m[31m[0m
    [1;34m15[0m:     @books = [1;34;4mBook[0m.search(@keyword)
    [1;34m16[0m:     @book = [1;34;4mBook[0m.new
    [1;34m17[0m:     render [31m[1;31m"[0m[31mbooks/index[1;31m"[0m[31m[0m
    [1;34m18[0m:   [32mend[0m
    [1;34m19[0m: 
    [1;34m20[0m: [32mend[0m

