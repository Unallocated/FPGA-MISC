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

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/root/FPGA-MISC/FFT with VGA/sqrt_core_test.vhd";
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_1006216973935652998_1035706684(char *, char *, char *, char *, int );
char *ieee_p_1242562249_sub_1701011461141717515_1035706684(char *, char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_2177518728674633585_1035706684(char *, char *, char *, char *, char *, char *);


static void work_a_4176555095_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 3024U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(78, ng0);
    t2 = (t0 + 3656);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(79, ng0);
    t2 = (t0 + 1808U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 2832);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(80, ng0);
    t2 = (t0 + 3656);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(81, ng0);
    t2 = (t0 + 1808U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 2832);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_4176555095_2372691052_p_1(char *t0)
{
    char t4[16];
    char t5[16];
    char t6[16];
    char t9[16];
    char t14[16];
    char t15[16];
    char t19[16];
    char *t1;
    char *t2;
    int64 t3;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t16;
    char *t17;
    char *t18;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    int64 t30;

LAB0:    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(89, ng0);
    t3 = (100 * 1000LL);
    t2 = (t0 + 3080);
    xsi_process_wait(t2, t3);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(90, ng0);
    t2 = (t0 + 1928U);
    t7 = *((char **)t2);
    t2 = (t0 + 5720U);
    t8 = ieee_p_1242562249_sub_1006216973935652998_1035706684(IEEE_P_1242562249, t6, t7, t2, 128);
    t10 = (t0 + 1928U);
    t11 = *((char **)t10);
    t10 = (t0 + 5720U);
    t12 = ieee_p_1242562249_sub_1006216973935652998_1035706684(IEEE_P_1242562249, t9, t11, t10, 128);
    t13 = ieee_p_1242562249_sub_2177518728674633585_1035706684(IEEE_P_1242562249, t5, t8, t6, t12, t9);
    t16 = (t0 + 2048U);
    t17 = *((char **)t16);
    t16 = (t0 + 5736U);
    t18 = ieee_p_1242562249_sub_1006216973935652998_1035706684(IEEE_P_1242562249, t15, t17, t16, 128);
    t20 = (t0 + 2048U);
    t21 = *((char **)t20);
    t20 = (t0 + 5736U);
    t22 = ieee_p_1242562249_sub_1006216973935652998_1035706684(IEEE_P_1242562249, t19, t21, t20, 128);
    t23 = ieee_p_1242562249_sub_2177518728674633585_1035706684(IEEE_P_1242562249, t14, t18, t15, t22, t19);
    t24 = ieee_p_1242562249_sub_1701011461141717515_1035706684(IEEE_P_1242562249, t4, t13, t5, t23, t14);
    t25 = (t0 + 3720);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    memcpy(t29, t24, 16U);
    xsi_driver_first_trans_fast(t25);
    xsi_set_current_line(92, ng0);
    t2 = (t0 + 1808U);
    t7 = *((char **)t2);
    t3 = *((int64 *)t7);
    t30 = (t3 * 10);
    t2 = (t0 + 3080);
    xsi_process_wait(t2, t30);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(96, ng0);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    goto LAB2;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

}


extern void work_a_4176555095_2372691052_init()
{
	static char *pe[] = {(void *)work_a_4176555095_2372691052_p_0,(void *)work_a_4176555095_2372691052_p_1};
	xsi_register_didat("work_a_4176555095_2372691052", "isim/sqrt_core_test_isim_beh.exe.sim/work/a_4176555095_2372691052.didat");
	xsi_register_executes(pe);
}
