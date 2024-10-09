Vim�UnDo� 湯3� �XmVX��[�å)��Էi:]�Ķ        return 0;      	      (       (   (   (    f��<    _�                            ����                                                                                                                                                                                                                                                                                                                                       U           V        f���     �             P   template <typename T>   AEigen::Matrix<T,1,3> angle_via_acos(const Eigen::Matrix<T,3,3> V)   {   !  // Compute squared edge lengths     Eigen::Matrix<T,1,3> L_sq;   .  L_sq(0) = (V.row(2)-V.row(1)).squaredNorm();   .  L_sq(1) = (V.row(0)-V.row(2)).squaredNorm();   .  L_sq(2) = (V.row(1)-V.row(0)).squaredNorm();     Eigen::Matrix<T,1,3> A;     for(int i = 0;i<3;i++)     {   #    const auto s1 = L_sq((0+i)%3);    #    const auto s2 = L_sq((1+i)%3);    #    const auto s3 = L_sq((2+i)%3);    1    A(i) = acos((s3 + s2 - s1)/(2.*sqrt(s3*s2)));     }     return A;   }       template <typename T>   BEigen::Matrix<T,1,3> angle_via_kahan(const Eigen::Matrix<T,3,3> V)   {     // Compute edge lengths     Eigen::Matrix<T,1,3> L;   *  L(0) = (V.row(2)-V.row(1)).stableNorm();   *  L(1) = (V.row(0)-V.row(2)).stableNorm();   *  L(2) = (V.row(1)-V.row(0)).stableNorm();     Eigen::Matrix<T,1,3> A;     for(int d = 0;d<3;d++)     {       auto c = L(d);       auto a = L((d+1)%3);       auto b = L((d+2)%3);   4    // If necessary, swap a and b so that a ≥ b .        if(a<b){ std::swap(a,b); }   E    // Then perform two more comparisons to decide whether and how to   0    // compute an intermediate quantity µ thus:   	    T mu;       if(b>=c && c>=0)       {         mu = c-(a-b);       }else if(c>b && b>=0)       {         mu = b-(a-c);   	    }else       {   ;      // the data are not side–lengths of a real triangle   1      A(d) = std::numeric_limits<T>::quiet_NaN();         continue;       }   5    // mu has been computed, attempt to compute angle   ?    A(d) = 2.0*atan(sqrt(((a-b)+c)*mu/((a+(b+c))*((a-c)+b)) ));     }     return A;   }       template <typename T>   AEigen::Matrix<T,1,3> angle_via_unit(const Eigen::Matrix<T,3,3> V)   {     Eigen::Matrix<T,1,3> A;     for(int d = 0;d<3;d++)     {   1    auto v1 = (V.row(d) - V.row((d+1)%3)).eval();   1    auto v2 = (V.row(d) - V.row((d+2)%3)).eval();   c    A(d)= T(2) * atan((v1/v1.norm() - v2/v2.norm()).norm() / (v1/v1.norm() + v2/v2.norm()).norm());     }     return A;   }           template <typename T>   =void validate(std::string name, const Eigen::Matrix<T,1,3> A)   {   2  printf("  %20s<%6s>: %11g %s %11g %s %11g %s\n",       name.c_str(),   6    std::is_same<T,float>::value ? "float" : "double",   !    A(0),A(0)==0 ? "❌" : "✅",   !    A(1), A(1)>2 ? "✅" : "❌",   "    A(2), A(2)<1 ? "✅" : "❌");   }5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        f���     �                 5�_�                           ����                                                                                                                                                                                                                                                                                                                                                       f���     �   
               // Eigen::Matrix3d V;   	   // V<<      //    0,0,0,      //    1,1,0,      //    1+nudge,1,0;5�_�                           ����                                                                                                                                                                                                                                                                                                                                                       f��     �                   �             5�_�                           ����                                                                                                                                                                                                                                                                                                                                                       f��    �                    std::co�              �                   5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             f��     �                 5�_�      	                      ����                                                                                                                                                                                                                                                                                                                                                             f��     �             5�_�      
           	           ����                                                                                                                                                                                                                                                                                                                                                             f��!     �              5�_�   	              
           ����                                                                                                                                                                                                                                                                                                                                                             f��!     �                 5�_�   
                        ����                                                                                                                                                                                                                                                                                                                                                             f��1    �                #include <Eigen/Core>5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             f��X    �                #include <Eigen/Dense>5�_�                    
        ����                                                                                                                                                                                                                                                                                                                            
                      V        f��g    �   	   
              Eigen::Matrix3d V;       V<<          0,0,0,          1,1,0,          1+nudge,1,0;              std::cout<<V<<std::endl;5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             f��r     �                 6#pragma cling add_include_path("/usr/include/eigen3/")5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             f��s     �                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             f��y    �                 �             5�_�                       	    ����                                                                                                                                                                                                                                                                                                                                                             f���     �                 return 1;5�_�                       	    ����                                                                                                                                                                                                                                                                                                                                                             f���     �               
  return ;5�_�                       	    ����                                                                                                                                                                                                                                                                                                                                                             f���     �                 return -;5�_�                       	    ����                                                                                                                                                                                                                                                                                                                                                             f���    �               
  return ;5�_�                       
    ����                                                                                                                                                                                                                                                                                                                                                             f���    �                #include <iostream>5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             f���     �                #include <stdio>5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             f���    �                #include <stdio.h>5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             f���     �             5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             f���     �                �             5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             f���     �                !  for(double nudge : {1e-7,1e-8})5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             f���     �                 �             �             5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             f���     �                �             �             5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             f���   	 �               #include <Eigen/Dense>5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             f���     �               
int main()5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             f���     �                  return 0;5�_�      !                       ����                                                                                                                                                                                                                                                                                                                                                             f���   
 �                 5�_�       "           !           ����                                                                                                                                                                                                                                                                                                                                                  V        f��     �                +  std::vector<double> nudges = {1e-7,1e-8};     for (double nudge : nudges)     {            printf("nudge: %g\n",nudge);   3    //validate("angle_via_acos",angle_via_acos(V));   5    //validate("angle_via_kahan",angle_via_kahan(V));   3    //validate("angle_via_unit",angle_via_unit(V));   $    //if( float(1+nudge) > float(1))       //{   J    //  validate("angle_via_acos",angle_via_acos(V.cast<float>().eval()));   L    //  validate("angle_via_kahan",angle_via_kahan(V.cast<float>().eval()));   J    //  validate("angle_via_unit",angle_via_unit(V.cast<float>().eval()));       //}     }     5�_�   !   #           "           ����                                                                                                                                                                                                                                                                                                                                                  V        f��     �               void main()5�_�   "   $           #          ����                                                                                                                                                                                                                                                                                                                                                  V        f��     �                 �             5�_�   #   %           $      	    ����                                                                                                                                                                                                                                                                                                                                                  V        f��$     �                 return 1;5�_�   $   &           %      	    ����                                                                                                                                                                                                                                                                                                                                                  V        f��%    �               
  return ;5�_�   %   '           &           ����                                                                                                                                                                                                                                                                                                                                                             f��-    �                #include <vector>5�_�   &   (           '      	    ����                                                                                                                                                                                                                                                                                                                                                             f��;     �                 return 0;5�_�   '               (      	    ����                                                                                                                                                                                                                                                                                                                                                             f��;    �               
  return ;5�_�                             ����                                                                                                                                                                                                                                                                                                                                                  V        f���     �         o      Wtemplate <typename T> Eigen::Matrix<T,1,3> angle_via_acos(const Eigen::Matrix<T,3,3> V)5��