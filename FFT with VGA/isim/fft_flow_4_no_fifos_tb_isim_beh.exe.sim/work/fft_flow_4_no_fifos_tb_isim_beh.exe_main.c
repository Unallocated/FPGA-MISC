/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *IEEE_P_0774719531;
char *IEEE_P_3499444699;
char *XILINXCORELIB_P_1849098369;
char *XILINXCORELIB_P_2602938013;
char *IEEE_P_3972351953;
char *XILINXCORELIB_P_3381355550;
char *IEEE_P_1242562249;
char *XILINXCORELIB_P_1837083571;
char *STD_TEXTIO;
char *UNISIM_P_3222816464;
char *IEEE_P_2717149903;
char *UNISIM_P_0947159679;
char *XILINXCORELIB_P_3160202542;
char *XILINXCORELIB_P_3155556343;
char *IEEE_P_1367372525;
char *IEEE_P_3620187407;
char *XILINXCORELIB_P_2342578331;
char *WORK_P_3851841154;
char *XILINXCORELIB_P_1317117406;
char *IEEE_P_3564397177;
char *XILINXCORELIB_P_3743709326;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_1242562249_init();
    unisim_p_0947159679_init();
    std_textio_init();
    ieee_p_2717149903_init();
    ieee_p_1367372525_init();
    unisim_p_3222816464_init();
    ieee_p_3499444699_init();
    work_p_3851841154_init();
    ieee_p_3620187407_init();
    ieee_p_0774719531_init();
    ieee_p_3564397177_init();
    unisim_a_2562466605_1496654361_init();
    unisim_a_1717296735_4086321779_init();
    unisim_a_3911257326_1331108868_init();
    unisim_a_0868425105_1864968857_init();
    unisim_a_3519694068_2693788048_init();
    unisim_a_1769350033_2693788048_init();
    unisim_a_1205172842_3616886268_init();
    unisim_a_1398595224_1990404599_init();
    unisim_a_3392214784_1331108868_init();
    unisim_a_0250118398_1331108868_init();
    unisim_a_0490859109_3731405331_init();
    unisim_a_3208337549_3731405331_init();
    unisim_a_3504150236_3731405331_init();
    unisim_a_2763665805_3731405331_init();
    unisim_a_0900199298_3731405331_init();
    unisim_a_2622885206_3731405331_init();
    unisim_a_2718997652_3731405331_init();
    unisim_a_2152598291_3731405331_init();
    unisim_a_3330121465_3731405331_init();
    unisim_a_0842964167_3731405331_init();
    unisim_a_2548838872_3634591992_init();
    unisim_a_1099881057_3634591992_init();
    unisim_a_3268492514_3634591992_init();
    unisim_a_1201644039_3634591992_init();
    unisim_a_1553237934_3634591992_init();
    unisim_a_3355456986_3634591992_init();
    unisim_a_3318274923_3634591992_init();
    unisim_a_1288677563_3634591992_init();
    unisim_a_2011469726_3634591992_init();
    unisim_a_4054976466_3634591992_init();
    unisim_a_2121384304_3723259517_init();
    unisim_a_2261302797_3723259517_init();
    unisim_a_3822252837_3752513572_init();
    unisim_a_0460033112_3752513572_init();
    unisim_a_3449702363_3752513572_init();
    unisim_a_2545276020_3752513572_init();
    unisim_a_1446710196_3752513572_init();
    unisim_a_1863101193_3752513572_init();
    unisim_a_2910599432_3676810390_init();
    unisim_a_2363982922_3676810390_init();
    unisim_a_2887667072_3676810390_init();
    unisim_a_1678563307_3676810390_init();
    unisim_a_0596530579_3676810390_init();
    unisim_a_0233443967_3676810390_init();
    unisim_a_3927364358_3676810390_init();
    unisim_a_3808442996_3676810390_init();
    unisim_a_2633375775_3676810390_init();
    unisim_a_3738318759_3676810390_init();
    unisim_a_4147975967_3676810390_init();
    unisim_a_2211114385_3676810390_init();
    unisim_a_0827283087_3676810390_init();
    unisim_a_2080165336_3676810390_init();
    unisim_a_0824389346_3676810390_init();
    unisim_a_2380710914_3676810390_init();
    unisim_a_4177737373_3676810390_init();
    unisim_a_1931785003_3676810390_init();
    unisim_a_2729128116_3676810390_init();
    unisim_a_0374440060_3676810390_init();
    unisim_a_0427616679_3676810390_init();
    unisim_a_1646226234_1266530935_init();
    unisim_a_3484885994_2523279426_init();
    unisim_a_0350208134_1521797606_init();
    unisim_a_1306507066_0234597810_init();
    unisim_a_2456189163_0111667855_init();
    unisim_a_1836616293_3089378898_init();
    unisim_a_4267973181_3672491681_init();
    unisim_a_1255468339_3672491681_init();
    unisim_a_1163987553_3672491681_init();
    unisim_a_3055263662_1392679692_init();
    unisim_a_0955942486_3458372907_init();
    unisim_a_1916428545_3403034321_init();
    unisim_a_1471037635_3458372907_init();
    work_a_1259229068_0632001823_init();
    work_a_1084957869_3212880686_init();
    ieee_p_3972351953_init();
    xilinxcorelib_p_1837083571_init();
    xilinxcorelib_p_2342578331_init();
    xilinxcorelib_p_1317117406_init();
    xilinxcorelib_a_1057425297_3212880686_init();
    work_a_0799548389_1661361302_init();
    unisim_a_0780662263_2014779070_init();
    unisim_a_0490669968_2930107152_init();
    unisim_a_3950408493_1532504268_init();
    unisim_a_1490675510_1976025627_init();
    work_a_3459598153_0912031422_init();
    xilinxcorelib_p_3381355550_init();
    xilinxcorelib_p_1849098369_init();
    xilinxcorelib_p_2602938013_init();
    xilinxcorelib_p_3160202542_init();
    xilinxcorelib_p_3155556343_init();
    xilinxcorelib_p_3743709326_init();
    xilinxcorelib_a_0006162580_3212880686_init();
    xilinxcorelib_a_3854613474_3212880686_init();
    xilinxcorelib_a_0254995786_3212880686_init();
    xilinxcorelib_a_3377288706_3212880686_init();
    xilinxcorelib_a_1069409733_3212880686_init();
    xilinxcorelib_a_3763129690_3212880686_init();
    xilinxcorelib_a_3209556698_3212880686_init();
    xilinxcorelib_a_1622989381_3212880686_init();
    xilinxcorelib_a_2948401865_3212880686_init();
    xilinxcorelib_a_1243855295_3212880686_init();
    xilinxcorelib_a_2164232900_3212880686_init();
    work_a_2150120696_4013789287_init();
    work_a_2287606572_3212880686_init();
    work_a_2340500677_2372691052_init();


    xsi_register_tops("work_a_2340500677_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_0774719531 = xsi_get_engine_memory("ieee_p_0774719531");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    XILINXCORELIB_P_1849098369 = xsi_get_engine_memory("xilinxcorelib_p_1849098369");
    XILINXCORELIB_P_2602938013 = xsi_get_engine_memory("xilinxcorelib_p_2602938013");
    IEEE_P_3972351953 = xsi_get_engine_memory("ieee_p_3972351953");
    XILINXCORELIB_P_3381355550 = xsi_get_engine_memory("xilinxcorelib_p_3381355550");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    XILINXCORELIB_P_1837083571 = xsi_get_engine_memory("xilinxcorelib_p_1837083571");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    UNISIM_P_3222816464 = xsi_get_engine_memory("unisim_p_3222816464");
    IEEE_P_2717149903 = xsi_get_engine_memory("ieee_p_2717149903");
    UNISIM_P_0947159679 = xsi_get_engine_memory("unisim_p_0947159679");
    XILINXCORELIB_P_3160202542 = xsi_get_engine_memory("xilinxcorelib_p_3160202542");
    XILINXCORELIB_P_3155556343 = xsi_get_engine_memory("xilinxcorelib_p_3155556343");
    IEEE_P_1367372525 = xsi_get_engine_memory("ieee_p_1367372525");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    XILINXCORELIB_P_2342578331 = xsi_get_engine_memory("xilinxcorelib_p_2342578331");
    WORK_P_3851841154 = xsi_get_engine_memory("work_p_3851841154");
    XILINXCORELIB_P_1317117406 = xsi_get_engine_memory("xilinxcorelib_p_1317117406");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");
    XILINXCORELIB_P_3743709326 = xsi_get_engine_memory("xilinxcorelib_p_3743709326");

    return xsi_run_simulation(argc, argv);

}
