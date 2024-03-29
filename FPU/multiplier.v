module dadda24(input [23:0]a,input [23:0]b,output [48:0]y);

wire [583:0]s1; 
wire [583:0]c1;
reg w[23:0][23:0];
integer i,j;
always@(*)
begin
for(i=0;i<=23;i=i+1)
begin
	for(j=0;j<=23;j=j+1)
	begin
		w[i][j]=a[i]& b[j];
	end
end	 
end
ha n1(w[19][0],w[18][1],s1[0],c1[0]);
 
fai n2(w[20][0],w[19][1],w[18][2],s1[1],c1[1]);
ha n3(w[17][3],w[16][4],s1[2],c1[2]);
 
fai n4(w[21][0],w[20][1],w[19][2],s1[3],c1[3]);
fai n5(w[18][3],w[17][4],w[16][5],s1[4],c1[4]);
ha n6(w[15][6],w[14][7],s1[5],c1[5]);
 
fai n7(w[22][0],w[21][1],w[20][2],s1[6],c1[6]);
fai n8(w[19][3],w[18][4],w[17][5],s1[7],c1[7]);
fai n9(w[16][6],w[15][7],w[14][8],s1[8],c1[8]);
ha n10(w[13][9],w[12][10],s1[9],c1[9]);
 
fai n11(w[23][0],w[22][1],w[21][2],s1[10],c1[10]);
fai n12(w[20][3],w[19][4],w[18][5],s1[11],c1[11]);
fai n13(w[17][6],w[16][7],w[15][8],s1[12],c1[12]);
fai n14(w[14][9],w[13][10],w[12][11],s1[13],c1[13]);
ha n15(w[11][12],w[10][13],s1[14],c1[14]);
 
fai n16(w[23][1],w[22][2],w[21][3],s1[15],c1[15]);
fai n17(w[20][4],w[19][5],w[18][6],s1[16],c1[16]);
fai n18(w[17][7],w[16][8],w[15][9],s1[17],c1[17]);
fai n19(w[14][10],w[13][11],w[12][12],s1[18],c1[18]);
ha n20(w[11][13],w[10][14],s1[19],c1[19]);
 
fai n21(w[23][2],w[22][3],w[21][4],s1[20],c1[20]);
fai n22(w[20][5],w[19][6],w[18][7],s1[21],c1[21]);
fai n23(w[17][8],w[16][9],w[15][10],s1[22],c1[22]);
fai n24(w[14][11],w[13][12],w[12][13],s1[23],c1[23]);
 
fai n25(w[23][3],w[22][4],w[21][5],s1[24],c1[24]);
fai n26(w[20][6],w[19][7],w[18][8],s1[25],c1[25]);
fai n27(w[17][9],w[16][10],w[15][11],s1[26],c1[26]);
 
fai n28(w[23][4],w[22][5],w[21][6],s1[27],c1[27]);
fai n29(w[20][7],w[19][8],w[18][9],s1[28],c1[28]);
 
ha n30(w[23][5],w[22][6],s1[29],c1[29]);
ha n31(w[21][7],w[20][8],s1[30],c1[30]);
 
ha n32(w[23][6],w[22][7],s1[31],c1[31]);

//second stage//
ha n33(w[13][0],w[12][1],s1[32],c1[32]);
 
fai n34(w[14][0],w[13][1],w[12][2],s1[33],c1[33]);
ha n35(w[11][3],w[10][4],s1[34],c1[34]);
 
fai n36(w[15][0],w[14][1],w[13][2],s1[35],c1[35]);
fai n37(w[12][3],w[11][4],w[10][5],s1[36],c1[36]);
ha n38(w[9][6],w[8][7],s1[37],c1[37]);
 
fai n39(w[16][0],w[15][1],w[14][2],s1[38],c1[38]);
fai n40(w[13][3],w[12][4],w[11][5],s1[39],c1[39]);
ha n41(w[10][6],w[9][7],s1[40],c1[40]);
ha n42(w[8][8],w[7][9],s1[41],c1[41]);
ha n43(w[6][10],w[5][11],s1[42],c1[42]);
 
fai n44(w[17][0],w[16][1],w[15][2],s1[43],c1[43]);
fai n45(w[14][3],w[13][4],w[12][5],s1[44],c1[44]);
fai n46(w[11][6],w[10][7],w[9][8],s1[45],c1[45]);
fai n47(w[8][9],w[7][10],w[6][11],s1[46],c1[46]);
fai n48(w[5][12],w[4][13],w[3][14],s1[47],c1[47]);
 
fai n49(w[18][0],w[17][1],w[16][2],s1[48],c1[48]);
fai n50(w[15][3],w[14][4],w[13][5],s1[49],c1[49]);
fai n51(w[12][6],w[11][7],w[10][8],s1[50],c1[50]);
fai n52(w[9][9],w[8][10],w[7][11],s1[51],c1[51]);
fai n53(w[6][12],w[5][13],w[4][14],s1[52],c1[52]);
ha n54(w[3][15],w[2][16],s1[53],c1[53]);
 
fai n55(s1[0],w[17][2],w[16][3],s1[54],c1[54]);
fai n56(w[15][4],w[14][5],w[13][6],s1[55],c1[55]);
fai n57(w[12][7],w[11][8],w[10][9],s1[56],c1[56]);
fai n58(w[9][10],w[8][11],w[7][12],s1[57],c1[57]);
fai n59(w[6][13],w[5][14],w[4][15],s1[58],c1[58]);
ha n60(w[3][16],w[2][17],s1[59],c1[59]);
ha n61(w[1][18],w[0][19],s1[60],c1[60]);
 
fai n62(c1[0],s1[1],s1[2],s1[61],c1[61]);
fai n63(w[15][5],w[14][6],w[13][7],s1[62],c1[62]);
fai n64(w[12][8],w[11][9],w[10][10],s1[63],c1[63]);
fai n65(w[9][11],w[8][12],w[7][13],s1[64],c1[64]);
fai n66(w[6][14],w[5][15],w[4][16],s1[65],c1[65]);
fai n67(w[3][17],w[2][18],w[1][19],s1[66],c1[66]);
ha n68(w[0][20],c1[60],s1[67],c1[67]);
 
fai n69(c1[1],s1[3],c1[2],s1[68],c1[68]);
fai n70(s1[4],s1[5],w[13][8],s1[69],c1[69]);
fai n71(w[12][9],w[11][10],w[10][11],s1[70],c1[70]);
fai n72(w[9][12],w[8][13],w[7][14],s1[71],c1[71]);
fai n73(w[6][15],w[5][16],w[4][17],s1[72],c1[72]);
fai n74(w[3][18],w[2][19],w[1][20],s1[73],c1[73]);
ha n75(w[0][21],c1[67],s1[74],c1[74]);
 
fai n76(c1[3],s1[6],c1[4],s1[75],c1[75]);
fai n77(s1[7],c1[5],s1[8],s1[76],c1[76]);
fai n78(s1[9],w[11][11],w[10][12],s1[77],c1[77]);
fai n79(w[9][13],w[8][14],w[7][15],s1[78],c1[78]);
fai n80(w[6][16],w[5][17],w[4][18],s1[79],c1[79]);
fai n81(w[3][19],w[2][20],w[1][21],s1[80],c1[80]);
ha n82(w[0][22],c1[74],s1[81],c1[81]);
 
fai n83(c1[6],s1[10],c1[7],s1[82],c1[82]);
fai n84(s1[11],c1[8],s1[12],s1[83],c1[83]);
fai n85(c1[9],s1[13],s1[14],s1[84],c1[84]);
fai n86(w[9][14],w[8][15],w[7][16],s1[85],c1[85]);
fai n87(w[6][17],w[5][18],w[4][19],s1[86],c1[86]);
fai n88(w[3][20],w[2][21],w[1][22],s1[87],c1[87]);
ha n89(w[0][23],c1[81],s1[88],c1[88]);
 
fai n90(c1[10],s1[15],c1[11],s1[89],c1[89]);
fai n91(s1[16],c1[12],s1[17],s1[90],c1[90]);
fai n92(c1[13],s1[18],c1[14],s1[91],c1[91]);
fai n93(s1[19],w[9][15],w[8][16],s1[92],c1[92]);
fai n94(w[7][17],w[6][18],w[5][19],s1[93],c1[93]);
fai n95(w[4][20],w[3][21],w[2][22],s1[94],c1[94]);
ha n96(w[1][23],c1[88],s1[95],c1[95]);
 
fai n97(c1[15],s1[20],c1[16],s1[96],c1[96]);
fai n98(s1[21],c1[17],s1[22],s1[97],c1[97]);
fai n99(c1[18],s1[23],c1[19],s1[98],c1[98]);
fai n100(w[11][14],w[10][15],w[9][16],s1[99],c1[99]);
fai n101(w[8][17],w[7][18],w[6][19],s1[100],c1[100]);
fai n102(w[5][20],w[4][21],w[3][22],s1[101],c1[101]);
ha n103(w[2][23],c1[95],s1[102],c1[102]);
 
fai n104(c1[20],s1[24],c1[21],s1[103],c1[103]);
fai n105(s1[25],c1[22],s1[26],s1[104],c1[104]);
fai n106(c1[23],w[14][12],w[13][13],s1[105],c1[105]);
fai n107(w[12][14],w[11][15],w[10][16],s1[106],c1[106]);
fai n108(w[9][17],w[8][18],w[7][19],s1[107],c1[107]);
fai n109(w[6][20],w[5][21],w[4][22],s1[108],c1[108]);
ha n110(w[3][23],c1[102],s1[109],c1[109]);
 
fai n111(c1[24],s1[27],c1[25],s1[110],c1[110]);
fai n112(s1[28],c1[26],w[17][10],s1[111],c1[111]);
fai n113(w[16][11],w[15][12],w[14][13],s1[112],c1[112]);
fai n114(w[13][14],w[12][15],w[11][16],s1[113],c1[113]);
fai n115(w[10][17],w[9][18],w[8][19],s1[114],c1[114]);
fai n116(w[7][20],w[6][21],w[5][22],s1[115],c1[115]);
ha n117(w[4][23],c1[109],s1[116],c1[116]);
 
fai n118(c1[27],s1[29],c1[28],s1[117],c1[117]);
fai n119(s1[30],w[19][9],w[18][10],s1[118],c1[118]);
fai n120(w[17][11],w[16][12],w[15][13],s1[119],c1[119]);
fai n121(w[14][14],w[13][15],w[12][16],s1[120],c1[120]);
fai n122(w[11][17],w[10][18],w[9][19],s1[121],c1[121]);
fai n123(w[8][20],w[7][21],w[6][22],s1[122],c1[122]);
ha n124(w[5][23],c1[116],s1[123],c1[123]);
 
fai n125(c1[29],s1[31],c1[30],s1[124],c1[124]);
fai n126(w[21][8],w[20][9],w[19][10],s1[125],c1[125]);
fai n127(w[18][11],w[17][12],w[16][13],s1[126],c1[126]);
fai n128(w[15][14],w[14][15],w[13][16],s1[127],c1[127]);
fai n129(w[12][17],w[11][18],w[10][19],s1[128],c1[128]);
fai n130(w[9][20],w[8][21],w[7][22],s1[129],c1[129]);
ha n131(w[6][23],c1[123],s1[130],c1[130]);
 
fai n132(c1[31],w[23][7],w[22][8],s1[131],c1[131]);
fai n133(w[21][9],w[20][10],w[19][11],s1[132],c1[132]);
fai n134(w[18][12],w[17][13],w[16][14],s1[133],c1[133]);
fai n135(w[15][15],w[14][16],w[13][17],s1[134],c1[134]);
fai n136(w[12][18],w[11][19],w[10][20],s1[135],c1[135]);
fai n137(w[9][21],w[8][22],w[7][23],s1[136],c1[136]);
 
fai n138(w[23][8],w[22][9],w[21][10],s1[137],c1[137]);
fai n139(w[20][11],w[19][12],w[18][13],s1[138],c1[138]);
fai n140(w[17][14],w[16][15],w[15][16],s1[139],c1[139]);
fai n141(w[14][17],w[13][18],w[12][19],s1[140],c1[140]);
ha n142(w[11][20],w[10][21],s1[141],c1[141]);
 
fai n143(w[23][9],w[22][10],w[21][11],s1[142],c1[142]);
fai n144(w[20][12],w[19][13],w[18][14],s1[143],c1[143]);
fai n145(w[17][15],w[16][16],w[15][17],s1[144],c1[144]);
ha n146(w[14][18],w[13][19],s1[145],c1[145]);
 
fai n147(w[23][10],w[22][11],w[21][12],s1[146],c1[146]);
fai n148(w[20][13],w[19][14],w[18][15],s1[147],c1[147]);
ha n149(w[17][16],w[16][17],s1[148],c1[148]);
 
fai n150(w[23][11],w[22][12],w[21][13],s1[149],c1[149]);
ha n151(w[20][14],w[19][15],s1[150],c1[150]);
 
ha n152(w[23][12],w[22][13],s1[151],c1[151]);
 
// 3rd stage//
 
 
ha n153(w[9][0],w[8][1],s1[152],c1[152]);

fai n154(w[10][0],w[9][1],w[8][2],s1[153],c1[153]);
ha n155(w[7][3],w[6][4],s1[154],c1[154]);

fai n156(w[11][0],w[10][1],w[9][2],s1[155],c1[155]);
fai n157(w[8][3],w[7][4],w[6][5],s1[156],c1[156]);
ha n158(w[5][6],w[4][7],s1[157],c1[157]);

fai n159(w[12][0],w[11][1],w[10][2],s1[158],c1[158]);
fai n160(w[9][3],w[8][4],w[7][5],s1[159],c1[159]);
fai n161(w[6][6],w[5][7],w[4][8],s1[160],c1[160]);
ha n162(w[3][9],w[2][10],s1[161],c1[161]);

fai n163(s1[32],w[11][2],w[10][3],s1[162],c1[162]);
fai n164(w[9][4],w[8][5],w[7][6],s1[163],c1[163]);
fai n165(w[6][7],w[5][8],w[4][9],s1[164],c1[164]);
fai n166(w[3][10],w[2][11],w[1][12],s1[165],c1[165]);

fai n167(c1[32],s1[33],s1[34],s1[166],c1[166]);
fai n168(w[9][5],w[8][6],w[7][7],s1[167],c1[167]);
fai n169(w[6][8],w[5][9],w[4][10],s1[168],c1[168]);
fai n170(w[3][11],w[2][12],w[1][13],s1[169],c1[169]);

fai n171(c1[33],s1[35],c1[34],s1[170],c1[170]);
fai n172(s1[36],s1[37],w[7][8],s1[171],c1[171]);
fai n173(w[6][9],w[5][10],w[4][11],s1[172],c1[172]);
fai n174(w[3][12],w[2][13],w[1][14],s1[173],c1[173]);

fai n175(c1[35],s1[38],c1[36],s1[174],c1[174]);
fai n176(s1[39],c1[37],s1[40],s1[175],c1[175]);
fai n177(s1[41],s1[42],w[4][12],s1[176],c1[176]);
fai n178(w[3][13],w[2][14],w[1][15],s1[177],c1[177]);

fai n179(c1[38],s1[43],c1[39],s1[178],c1[178]);
fai n180(s1[44],c1[40],s1[45],s1[179],c1[179]);
fai n181(c1[41],s1[46],c1[42],s1[180],c1[180]);
fai n182(s1[47],w[2][15],w[1][16],s1[181],c1[181]);

fai n183(c1[43],s1[48],c1[44],s1[182],c1[182]);
fai n184(s1[49],c1[45],s1[50],s1[183],c1[183]);
fai n185(c1[46],s1[51],c1[47],s1[184],c1[184]);
fai n186(s1[52],s1[53],w[1][17],s1[185],c1[185]);

fai n187(c1[48],s1[54],c1[49],s1[186],c1[186]);
fai n188(s1[55],c1[50],s1[56],s1[187],c1[187]);
fai n189(c1[51],s1[57],c1[52],s1[188],c1[188]);
fai n190(s1[58],c1[53],s1[59],s1[189],c1[189]);

fai n191(c1[54],s1[61],c1[55],s1[190],c1[190]);
fai n192(s1[62],c1[56],s1[63],s1[191],c1[191]);
fai n193(c1[57],s1[64],c1[58],s1[192],c1[192]);
fai n194(s1[65],c1[59],s1[66],s1[193],c1[193]);

fai n195(c1[61],s1[68],c1[62],s1[194],c1[194]);
fai n196(s1[69],c1[63],s1[70],s1[195],c1[195]);
fai n197(c1[64],s1[71],c1[65],s1[196],c1[196]);
fai n198(s1[72],c1[66],s1[73],s1[197],c1[197]);

fai n199(c1[68],s1[75],c1[69],s1[198],c1[198]);
fai n200(s1[76],c1[70],s1[77],s1[199],c1[199]);
fai n201(c1[71],s1[78],c1[72],s1[200],c1[200]);
fai n202(s1[79],c1[73],s1[80],s1[201],c1[201]);

fai n203(c1[75],s1[82],c1[76],s1[202],c1[202]);
fai n204(s1[83],c1[77],s1[84],s1[203],c1[203]);
fai n205(c1[78],s1[85],c1[79],s1[204],c1[204]);
fai n206(s1[86],c1[80],s1[87],s1[205],c1[205]);

fai n207(c1[82],s1[89],c1[83],s1[206],c1[206]);
fai n208(s1[90],c1[84],s1[91],s1[207],c1[207]);
fai n209(c1[85],s1[92],c1[86],s1[208],c1[208]);
fai n210(s1[93],c1[87],s1[94],s1[209],c1[209]);

fai n211(c1[89],s1[96],c1[90],s1[210],c1[210]);
fai n212(s1[97],c1[91],s1[98],s1[211],c1[211]);
fai n213(c1[92],s1[99],c1[93],s1[212],c1[212]);
fai n214(s1[100],c1[94],s1[101],s1[213],c1[213]);

fai n215(c1[96],s1[103],c1[97],s1[214],c1[214]);
fai n216(s1[104],c1[98],s1[105],s1[215],c1[215]);
fai n217(c1[99],s1[106],c1[100],s1[216],c1[216]);
fai n218(s1[107],c1[101],s1[108],s1[217],c1[217]);

fai n219(c1[103],s1[110],c1[104],s1[218],c1[218]);
fai n220(s1[111],c1[105],s1[112],s1[219],c1[219]);
fai n221(c1[106],s1[113],c1[107],s1[220],c1[220]);
fai n222(s1[114],c1[108],s1[115],s1[221],c1[221]);

fai n223(c1[110],s1[117],c1[111],s1[222],c1[222]);
fai n224(s1[118],c1[112],s1[119],s1[223],c1[223]);
fai n225(c1[113],s1[120],c1[114],s1[224],c1[224]);
fai n226(s1[121],c1[115],s1[122],s1[225],c1[225]);

fai n227(c1[117],s1[124],c1[118],s1[226],c1[226]);
fai n228(s1[125],c1[119],s1[126],s1[227],c1[227]);
fai n229(c1[120],s1[127],c1[121],s1[228],c1[228]);
fai n230(s1[128],c1[122],s1[129],s1[229],c1[229]);

fai n231(c1[124],s1[131],c1[125],s1[230],c1[230]);
fai n232(s1[132],c1[126],s1[133],s1[231],c1[231]);
fai n233(c1[127],s1[134],c1[128],s1[232],c1[232]);
fai n234(s1[135],c1[129],s1[136],s1[233],c1[233]);

fai n235(c1[131],s1[137],c1[132],s1[234],c1[234]);
fai n236(s1[138],c1[133],s1[139],s1[235],c1[235]);
fai n237(c1[134],s1[140],c1[135],s1[236],c1[236]);
fai n238(s1[141],c1[136],w[9][22],s1[237],c1[237]);

fai n239(c1[137],s1[142],c1[138],s1[238],c1[238]);
fai n240(s1[143],c1[139],s1[144],s1[239],c1[239]);
fai n241(c1[140],s1[145],c1[141],s1[240],c1[240]);
fai n242(w[12][20],w[11][21],w[10][22],s1[241],c1[241]);

fai n243(c1[142],s1[146],c1[143],s1[242],c1[242]);
fai n244(s1[147],c1[144],s1[148],s1[243],c1[243]);
fai n245(c1[145],w[15][18],w[14][19],s1[244],c1[244]);
fai n246(w[13][20],w[12][21],w[11][22],s1[245],c1[245]);

fai n247(c1[146],s1[149],c1[147],s1[246],c1[246]);
fai n248(s1[150],c1[148],w[18][16],s1[247],c1[247]);
fai n249(w[17][17],w[16][18],w[15][19],s1[248],c1[248]);
fai n250(w[14][20],w[13][21],w[12][22],s1[249],c1[249]);

fai n251(c1[149],s1[151],c1[150],s1[250],c1[250]);
fai n252(w[21][14],w[20][15],w[19][16],s1[251],c1[251]);
fai n253(w[18][17],w[17][18],w[16][19],s1[252],c1[252]);
fai n254(w[15][20],w[14][21],w[13][22],s1[253],c1[253]);

fai n255(c1[151],w[23][13],w[22][14],s1[254],c1[254]);
fai n256(w[21][15],w[20][16],w[19][17],s1[255],c1[255]);
fai n257(w[18][18],w[17][19],w[16][20],s1[256],c1[256]);
ha n258(w[15][21],w[14][22],s1[257],c1[257]);
 
fai n259(w[23][14],w[22][15],w[21][16],s1[258],c1[258]);
fai n260(w[20][17],w[19][18],w[18][19],s1[259],c1[259]);
ha n261(w[17][20],w[16][21],s1[260],c1[260]);
 
fai n262(w[23][15],w[22][16],w[21][17],s1[261],c1[261]); 
ha n263(w[20][18],w[19][19],s1[262],c1[262]); 
 
ha n2614(w[23][16],w[22][17],s1[263],c1[263]);

//fourth stage//

ha n264 (w[6][0],w[5][1],s1[264],c1[264]);
 
fai n265(w[7][0],w[6][1],w[5][2],s1[265],c1[265]);
ha n266(w[4][3],w[3][4],s1[266],c1[266]);
 
fai n267(w[8][0],w[7][1],w[6][2],s1[267],c1[267]);
fai n268(w[5][3],w[4][4],w[3][5],s1[268],c1[268]);
ha n269(w[2][6],w[1][7],s1[269],c1[269]);
 
fai n270(s1[152],w[7][2],w[6][3],s1[270],c1[270]);
fai n271(w[5][4],w[4][5],w[3][6],s1[271],c1[271]);
fai n272(w[2][7],w[1][8],w[0][9],s1[272],c1[272]);
 
fai n273(c1[152],s1[153],s1[154],s1[273],c1[273]);
fai n274(w[5][5],w[4][6],w[3][7],s1[274],c1[274]);
fai n275(w[2][8],w[1][9],w[0][10],s1[275],c1[275]);
 
fai n276(c1[153],s1[155],c1[154],s1[276],c1[276]);
fai n277(s1[156],s1[157],w[3][8],s1[277],c1[277]);
fai n278(w[2][9],w[1][10],w[0][11],s1[278],c1[278]);
 
fai n279(c1[155],s1[158],c1[156],s1[279],c1[279]);
fai n280(s1[159],c1[157],s1[160],s1[280],c1[280]);
fai n281(s1[161],w[1][11],w[0][12],s1[281],c1[281]);
 
fai n282(c1[158],s1[162],c1[159],s1[282],c1[282]);
fai n283(s1[163],c1[160],s1[164],s1[283],c1[283]);
fai n284(c1[161],s1[165],w[0][13],s1[284],c1[284]);
 
fai n285(c1[162],s1[166],c1[163],s1[285],c1[285]);
fai n286(s1[167],c1[164],s1[168],s1[286],c1[286]);
fai n287(c1[165],s1[169],w[0][14],s1[287],c1[287]);
 
fai n288(c1[166],s1[170],c1[167],s1[288],c1[288]);
fai n289(s1[171],c1[168],s1[172],s1[289],c1[289]);
fai n290(c1[169],s1[173],w[0][15],s1[290],c1[290]);
 
fai n291(c1[170],s1[174],c1[171],s1[291],c1[291]);
fai n292(s1[175],c1[172],s1[176],s1[292],c1[292]);
fai n293(c1[173],s1[177],w[0][16],s1[293],c1[293]);
 
fai n294(c1[174],s1[178],c1[175],s1[294],c1[294]);
fai n295(s1[179],c1[176],s1[180],s1[295],c1[295]);
fai n296(c1[177],s1[181],w[0][17],s1[296],c1[296]);
 
fai n297(c1[178],s1[182],c1[179],s1[297],c1[297]);
fai n298(s1[183],c1[180],s1[184],s1[298],c1[298]);
fai n299(c1[181],s1[185],w[0][18],s1[299],c1[299]);
 
fai n3001(c1[182],s1[186],c1[183],s1[300],c1[300]);
fai n2981(s1[187],c1[184],s1[188],s1[301],c1[301]);
fai n2991(c1[185],s1[189],s1[60],s1[302],c1[302]);
 
fai n300(c1[186],s1[190],c1[187],s1[303],c1[303]);
fai n301(s1[191],c1[188],s1[192],s1[304],c1[304]);
fai n302(c1[189],s1[193],s1[67],s1[305],c1[305]);
 
fai n303(c1[190],s1[194],c1[191],s1[306],c1[306]);
fai n304(s1[195],c1[192],s1[196],s1[307],c1[307]);
fai n305(c1[193],s1[197],s1[74],s1[308],c1[308]);
 
fai n306(c1[194],s1[198],c1[195],s1[309],c1[309]);
fai n307(s1[199],c1[196],s1[200],s1[310],c1[310]);
fai n308(c1[197],s1[201],s1[81],s1[311],c1[311]);
 
fai n309(c1[198],s1[202],c1[199],s1[312],c1[312]);
fai n310(s1[203],c1[200],s1[204],s1[313],c1[313]);
fai n311(c1[201],s1[205],s1[88],s1[314],c1[314]);
 
fai n312(c1[202],s1[206],c1[203],s1[315],c1[315]);
fai n313(s1[207],c1[204],s1[208],s1[316],c1[316]);
fai n314(c1[205],s1[209],s1[95],s1[317],c1[317]);
 
fai n315(c1[206],s1[210],c1[207],s1[318],c1[318]);
fai n316(s1[211],c1[208],s1[212],s1[319],c1[319]);
fai n317(c1[209],s1[213],s1[102],s1[320],c1[320]);
 
fai n318(c1[210],s1[214],c1[211],s1[321],c1[321]);
fai n319(s1[215],c1[212],s1[216],s1[322],c1[322]);
fai n320(c1[213],s1[217],s1[109],s1[323],c1[323]);
 
fai n321(c1[214],s1[218],c1[215],s1[324],c1[324]);
fai n322(s1[219],c1[216],s1[220],s1[325],c1[325]);
fai n323(c1[217],s1[221],s1[116],s1[326],c1[326]);
 
fai n324(c1[218],s1[222],c1[219],s1[327],c1[327]);
fai n325(s1[223],c1[220],s1[224],s1[328],c1[328]);
fai n326(c1[221],s1[225],s1[123],s1[329],c1[329]);
 
fai n327(c1[222],s1[226],c1[223],s1[330],c1[330]);
fai n328(s1[227],c1[224],s1[228],s1[331],c1[331]);
fai n329(c1[225],s1[229],s1[130],s1[332],c1[332]);
 
fai n330(c1[226],s1[230],c1[227],s1[333],c1[333]);
fai n331(s1[231],c1[228],s1[232],s1[334],c1[334]);
fai n332(c1[229],s1[233],c1[130],s1[335],c1[335]);
 
fai n333(c1[230],s1[234],c1[231],s1[336],c1[336]);
fai n334(s1[235],c1[232],s1[236],s1[337],c1[337]);
fai n335(c1[233],s1[237],w[8][23],s1[338],c1[338]);
 
fai n336(c1[234],s1[238],c1[235],s1[339],c1[339]);
fai n337(s1[239],c1[236],s1[240],s1[340],c1[340]);
fai n338(c1[237],s1[241],w[9][23],s1[341],c1[341]);
 
fai n339(c1[238],s1[242],c1[239],s1[342],c1[342]);
fai n340(s1[243],c1[240],s1[244],s1[343],c1[343]);
fai n341(c1[241],s1[245],w[10][23],s1[344],c1[344]);
 
fai n342(c1[242],s1[246],c1[243],s1[345],c1[345]);
fai n343(s1[247],c1[244],s1[248],s1[346],c1[346]);
fai n344(c1[245],s1[249],w[11][23],s1[347],c1[347]);
 
fai n345(c1[246],s1[250],c1[247],s1[348],c1[348]);
fai n346(s1[251],c1[248],s1[252],s1[349],c1[349]);
fai n347(c1[249],s1[253],w[12][23],s1[350],c1[350]);
 
fai n348(c1[250],s1[254],c1[251],s1[351],c1[351]);
fai n349(s1[255],c1[252],s1[256],s1[352],c1[352]);
fai n350(c1[253],s1[257],w[13][23],s1[353],c1[353]);
 
fai n351(c1[254],s1[258],c1[255],s1[354],c1[354]);
fai n352(s1[259],c1[256],s1[260],s1[355],c1[355]);
fai n353(c1[257],w[15][22],w[14][23],s1[356],c1[356]);
 
fai n354(c1[258],s1[261],c1[259],s1[357],c1[357]);
fai n355(s1[262],c1[260],w[18][20],s1[358],c1[358]);
fai n356(w[17][21],w[16][22],w[15][23],s1[359],c1[359]);
 
fai n357(c1[261],s1[263],c1[262],s1[360],c1[360]);
fai n358(w[21][18],w[20][19],w[19][20],s1[361],c1[361]);
fai n359(w[18][21],w[17][22],w[16][23],s1[362],c1[362]);
 
fai n360(c1[263],w[23][17],w[22][18],s1[363],c1[363]);
fai n361(w[21][19],w[20][20],w[19][21],s1[364],c1[364]); 
ha n3616(w[18][22],w[17][23],s1[365],c1[365]);
 
fai n362(w[23][18],w[22][19],w[21][20],s1[366],c1[366]); 
ha n363(w[20][21],w[19][22],s1[367],c1[367]); 
 
ha n364(w[23][19],w[22][20],s1[368],c1[368]);
 
//fifth stage//
 
ha n365(w[4][0],w[3][1],s1[369],c1[369]);
 
fai n366(w[5][0],w[4][1],w[3][2],s1[370],c1[370]);
ha n367(w[2][3],w[1][4],s1[371],c1[371]);

fai n3661(s1[264],w[4][2],w[3][3],s1[372],c1[372]);
fai n3671(w[2][4],w[1][5],w[0][6],s1[373],c1[373]);

fai n368(c1[264],s1[265],s1[266],s1[374],c1[374]);
fai n369(w[2][5],w[1][6],w[0][7],s1[375],c1[375]);

fai n370(c1[265],s1[267],c1[266],s1[376],c1[376]);
fai n371(s1[268],s1[269],w[0][8],s1[377],c1[377]);

fai n372(c1[267],s1[270],c1[268],s1[378],c1[378]);
fai n373(s1[271],c1[269],s1[272],s1[379],c1[379]);

fai n374(c1[270],s1[273],c1[271],s1[380],c1[380]);
fai n375(s1[274],c1[272],s1[275],s1[381],c1[381]);

fai n376(c1[273],s1[276],c1[274],s1[382],c1[382]);
fai n377(s1[277],c1[275],s1[278],s1[383],c1[383]);

fai n378(c1[276],s1[279],c1[277],s1[384],c1[384]);
fai n379(s1[280],c1[278],s1[281],s1[385],c1[385]);

fai n380(c1[279],s1[282],c1[280],s1[386],c1[386]);
fai n381(s1[283],c1[281],s1[284],s1[387],c1[387]);

fai n382(c1[282],s1[285],c1[283],s1[388],c1[388]);
fai n383(s1[286],c1[284],s1[287],s1[389],c1[389]);

fai n384(c1[285],s1[288],c1[286],s1[390],c1[390]);
fai n385(s1[289],c1[287],s1[290],s1[391],c1[391]);

fai n386(c1[288],s1[291],c1[289],s1[392],c1[392]);
fai n387(s1[292],c1[290],s1[293],s1[393],c1[393]);

fai n388(c1[291],s1[294],c1[292],s1[394],c1[394]);
fai n389(s1[295],c1[293],s1[296],s1[395],c1[395]);

fai n390(c1[294],s1[297],c1[295],s1[396],c1[396]);
fai n391(s1[298],c1[296],s1[299],s1[397],c1[397]);

fai n392(c1[297],s1[300],c1[298],s1[398],c1[398]);
fai n393(s1[301],c1[299],s1[302],s1[399],c1[399]);

fai n394(c1[300],s1[303],c1[301],s1[400],c1[400]);
fai n395(s1[304],c1[302],s1[305],s1[401],c1[401]);

fai n396(c1[303],s1[306],c1[304],s1[402],c1[402]);
fai n397(s1[307],c1[305],s1[308],s1[403],c1[403]);

fai n398(c1[306],s1[309],c1[307],s1[404],c1[404]);
fai n399(s1[310],c1[308],s1[311],s1[405],c1[405]);

fai n400(c1[309],s1[312],c1[310],s1[406],c1[406]);
fai n401(s1[313],c1[311],s1[314],s1[407],c1[407]);

fai n402(c1[312],s1[315],c1[313],s1[408],c1[408]);
fai n403(s1[316],c1[314],s1[317],s1[409],c1[409]);

fai n404(c1[315],s1[318],c1[316],s1[410],c1[410]);
fai n405(s1[319],c1[317],s1[320],s1[411],c1[411]);

fai n406(c1[318],s1[321],c1[319],s1[412],c1[412]);
fai n407(s1[322],c1[320],s1[323],s1[413],c1[413]);

fai n408(c1[321],s1[324],c1[322],s1[414],c1[414]);
fai n409(s1[325],c1[323],s1[326],s1[415],c1[415]);

fai n410(c1[324],s1[327],c1[325],s1[416],c1[416]);
fai n411(s1[328],c1[326],s1[329],s1[417],c1[417]);

fai n412(c1[327],s1[330],c1[328],s1[418],c1[418]);
fai n413(s1[331],c1[329],s1[332],s1[419],c1[419]);

fai n415(c1[330],s1[333],c1[331],s1[420],c1[420]);
fai n416(s1[334],c1[332],s1[335],s1[421],c1[421]);

fai n417(c1[333],s1[336],c1[334],s1[422],c1[422]);
fai n418(s1[337],c1[335],s1[338],s1[423],c1[423]);

fai n419(c1[336],s1[339],c1[337],s1[424],c1[424]);
fai n420(s1[340],c1[338],s1[341],s1[425],c1[425]);

fai n421(c1[339],s1[342],c1[340],s1[426],c1[426]);
fai n422(s1[343],c1[341],s1[344],s1[427],c1[427]);

fai n423(c1[342],s1[345],c1[343],s1[428],c1[428]);
fai n424(s1[346],c1[344],s1[347],s1[429],c1[429]);

fai n425(c1[345],s1[348],c1[346],s1[430],c1[430]);
fai n426(s1[349],c1[347],s1[350],s1[431],c1[431]);

fai n427(c1[348],s1[351],c1[349],s1[432],c1[432]);
fai n428(s1[352],c1[350],s1[353],s1[433],c1[433]);

fai n429(c1[351],s1[354],c1[352],s1[434],c1[434]);
fai n430(s1[355],c1[353],s1[356],s1[435],c1[435]);

fai n431(c1[354],s1[357],c1[355],s1[436],c1[436]);
fai n432(s1[358],c1[356],s1[359],s1[437],c1[437]);

fai n433(c1[357],s1[360],c1[358],s1[438],c1[438]);
fai n434(s1[361],c1[359],s1[362],s1[439],c1[439]);

fai n435(c1[360],s1[363],c1[361],s1[440],c1[440]);
fai n436(s1[364],c1[362],s1[365],s1[441],c1[441]);

fai n437(c1[363],s1[366],c1[364],s1[442],c1[442]);
fai n438(s1[367],c1[365],w[18][23],s1[443],c1[443]);

fai n439(c1[366],s1[368],c1[367],s1[444],c1[444]);
fai n440(w[21][21],w[20][22],w[19][23],s1[445],c1[445]);

fai n441(c1[368],w[23][20],w[22][21],s1[446],c1[446]); 
ha n4416(w[21][22],w[20][23],s1[447],c1[447]); 
 
fai n4417(w[23][21],w[22][22],w[21][23],s1[448],c1[448]);

// sixth stage//

ha n442(w[3][0],w[2][1],s1[449],c1[449]);
fai n443(s1[369],w[2][2],w[1][3],s1[450],c1[450]);
fai n4431(c1[369],s1[370],s1[371],s1[451],c1[451]);
fai n444(c1[370],s1[372],c1[371],s1[452],c1[452]);
fai n445(c1[372],s1[374],c1[373],s1[453],c1[453]);
fai n446(c1[374],s1[376],c1[375],s1[454],c1[454]);
fai n447(c1[376],s1[378 ],c1[377],s1[455],c1[455]);
fai n448(c1[378],s1[380],c1[379],s1[456],c1[456]);
fai n449(c1[380],s1[382],c1[381],s1[457],c1[457]);
fai n450(c1[382],s1[384],c1[383],s1[458],c1[458]);
fai n451(c1[384],s1[386],c1[385],s1[459],c1[459]);
fai n452(c1[386],s1[388],c1[387],s1[460],c1[460]);
fai n453(c1[388],s1[390],c1[389],s1[461],c1[461]);
fai n454(c1[390],s1[392],c1[391],s1[462],c1[462]);
fai n455(c1[392],s1[394],c1[393],s1[463],c1[463]);
fai n456(c1[394],s1[396],c1[395],s1[464],c1[464]);
fai n457(c1[396],s1[398],c1[397],s1[465],c1[465]);
fai n458(c1[398],s1[400],c1[399],s1[466],c1[466]);
fai n459(c1[400],s1[402],c1[401],s1[467],c1[467]);
fai n460(c1[402],s1[404],c1[403],s1[468],c1[468]);
fai n461(c1[404],s1[406],c1[405],s1[469],c1[469]);
fai n462(c1[406],s1[408],c1[407],s1[470],c1[470]);
fai n463(c1[408],s1[410],c1[409],s1[471],c1[471]);
fai n464(c1[410],s1[412],c1[411],s1[472],c1[472]);
fai n465(c1[412],s1[414],c1[413],s1[473],c1[473]);
fai n466(c1[414],s1[416],c1[415],s1[474],c1[474]);
fai n467(c1[416],s1[418],c1[417],s1[475],c1[475]);
fai n468(c1[418],s1[420],c1[419],s1[476],c1[476]);
fai n469(c1[420],s1[422],c1[421],s1[477],c1[477]);
fai n470(c1[422],s1[424],c1[423],s1[478],c1[478]);
fai n471(c1[424],s1[426],c1[425],s1[479],c1[479]);
fai n472(c1[426],s1[428],c1[427],s1[480],c1[480]);
fai n473(c1[428],s1[430],c1[429],s1[481],c1[481]);
fai n474(c1[430],s1[432],c1[431],s1[482],c1[482]);
fai n475(c1[432],s1[434],c1[433],s1[483],c1[483]);
fai n476(c1[434],s1[436],c1[435],s1[484],c1[484]);
fai n477(c1[436],s1[438],c1[437],s1[485],c1[485]);
fai n478(c1[438],s1[440],c1[439],s1[486],c1[486]);
fai n479(c1[440],s1[442],c1[441],s1[487],c1[487]);
fai n480(c1[442],s1[444],c1[443],s1[488],c1[488]);
fai n481(c1[444],s1[446],c1[445],s1[489],c1[489]); 
ha n4812(c1[446],s1[448],s1[490],c1[490]);
ha n482(c1[448],w[23][22],s1[491],c1[491]);
 
// seventh stage//
ha n483(w[2][0],w[1][1],s1[492],c1[492]);
fai n484(s1[449],w[1][2],w[0][3],s1[493],c1[493]);
fai n485(c1[449],s1[450],w[0][4],s1[494],c1[494]);
fai n486(c1[450],s1[451],w[0][5],s1[495],c1[495]);
fai n487(c1[451],s1[452],s1[373],s1[496],c1[496]);
fai n488(c1[452],s1[453],s1[375],s1[497],c1[497]);
fai n489(c1[453],s1[454],s1[377],s1[498],c1[498]);
fai n490(c1[454],s1[455],s1[379],s1[499],c1[499]);
fai n491(c1[455],s1[456],s1[381],s1[500],c1[500]);
fai n492(c1[456],s1[457],s1[383],s1[501],c1[501]);
fai n493(c1[457],s1[458],s1[385],s1[502],c1[502]);
fai n494(c1[458],s1[459],s1[387],s1[503],c1[503]);
fai n495(c1[459],s1[460],s1[389],s1[504],c1[504]);
fai n496(c1[460],s1[461],s1[391],s1[505],c1[505]);
fai n497(c1[461],s1[462],s1[393],s1[506],c1[506]);
fai n498(c1[462],s1[463],s1[395],s1[507],c1[507]);
fai n499(c1[463],s1[464],s1[397],s1[508],c1[508]);
fai n500(c1[464],s1[465],s1[399],s1[509],c1[509]);
fai n501(c1[465],s1[466],s1[401],s1[510],c1[510]);
fai n502(c1[466],s1[467],s1[403],s1[511],c1[511]);
fai n503(c1[467],s1[468],s1[405],s1[512],c1[512]);
fai n504(c1[468],s1[469],s1[407],s1[513],c1[513]);
fai n505(c1[469],s1[470],s1[409],s1[514],c1[514]);
fai n506(c1[470],s1[471],s1[411],s1[515],c1[515]);
fai n507(c1[471],s1[472],s1[413],s1[516],c1[516]);
fai n508(c1[472],s1[473],s1[415],s1[517],c1[517]);
fai n509(c1[473],s1[474],s1[417],s1[518],c1[518]);
fai n510(c1[474],s1[475],s1[419],s1[519],c1[519]);
fai n511(c1[475],s1[476],s1[421],s1[520],c1[520]);
fai n512(c1[476],s1[477],s1[423],s1[521],c1[521]);
fai n513(c1[477],s1[478],s1[425],s1[522],c1[522]);
fai n514(c1[478],s1[479],s1[427],s1[523],c1[523]);
fai n515(c1[479],s1[480],s1[429],s1[524],c1[524]);
fai n516(c1[480],s1[481],s1[431],s1[525],c1[525]);
fai n517(c1[481],s1[482],s1[433],s1[526],c1[526]);
fai n518(c1[482],s1[483],s1[435],s1[527],c1[527]);
fai n519(c1[483],s1[484],s1[437],s1[528],c1[528]);
fai n520(c1[484],s1[485],s1[439],s1[529],c1[529]);
fai n521(c1[485],s1[486],s1[441],s1[530],c1[530]);
fai n522(c1[486],s1[487],s1[443],s1[531],c1[531]);
fai n523(c1[487],s1[488],s1[445],s1[532],c1[532]);
fai n524(c1[488],s1[489],s1[447],s1[533],c1[533]);
fai n526(c1[489],s1[490],c1[447],s1[534],c1[534]); 
fai n5216(c1[490],s1[491],w[22][23],s1[535],c1[535]); 
ha n5217(c1[491],w[23][23],s1[536],c1[536]);

// final stage//

ha n527(w[1][0],w[0][1],s1[537],c1[537]);
fai n528(s1[492],w[0][2],c1[537],s1[538],c1[538]);
fai n529(c1[492],s1[493],c1[538],s1[539],c1[539]);
fai n531(c1[493],s1[494],c1[539],s1[540],c1[540]);
fai n532(c1[494],s1[495],c1[540],s1[541],c1[541]);
fai n533(c1[495],s1[496],c1[541],s1[542],c1[542]);
fai n534(c1[496],s1[497],c1[542],s1[543],c1[543]);
fai n535(c1[497],s1[498],c1[543],s1[544],c1[544]);
fai n536(c1[498],s1[499],c1[544],s1[545],c1[545]);
fai n537(c1[499],s1[500],c1[545],s1[546],c1[546]);
fai n538(c1[500],s1[501],c1[546],s1[547],c1[547]);
fai n539(c1[501],s1[502],c1[547],s1[548],c1[548]);
fai n540(c1[502],s1[503],c1[548],s1[549],c1[549]);
fai n541(c1[503],s1[504],c1[549],s1[550],c1[550]);
fai n542(c1[504],s1[505],c1[550],s1[551],c1[551]);
fai n543(c1[505],s1[506],c1[551],s1[552],c1[552]);
fai n544(c1[506],s1[507],c1[552],s1[553],c1[553]);
fai n545(c1[507],s1[508],c1[553],s1[554],c1[554]);
fai n546(c1[508],s1[509],c1[554],s1[555],c1[555]);
fai n547(c1[509],s1[510],c1[555],s1[556],c1[556]);
fai n548(c1[510],s1[511],c1[556],s1[557],c1[557]);
fai n549(c1[511],s1[512],c1[557],s1[558],c1[558]);
fai n550(c1[512],s1[513],c1[558],s1[559],c1[559]);
fai n551(c1[513],s1[514],c1[559],s1[560],c1[560]);
fai n552(c1[514],s1[515],c1[560],s1[561],c1[561]);
fai n553(c1[515],s1[516],c1[561],s1[562],c1[562]);
fai n554(c1[516],s1[517],c1[562],s1[563],c1[563]);
fai n555(c1[517],s1[518],c1[563],s1[564],c1[564]);
fai n556(c1[518],s1[519],c1[564],s1[565],c1[565]);
fai n557(c1[519],s1[520],c1[565],s1[566],c1[566]);
fai n558(c1[520],s1[521],c1[566],s1[567],c1[567]);
fai n559(c1[521],s1[522],c1[567],s1[568],c1[568]);
fai n560(c1[522],s1[523],c1[568],s1[569],c1[569]);
fai n561(c1[523],s1[524],c1[569],s1[570],c1[570]);
fai n562(c1[524],s1[525],c1[570],s1[571],c1[571]);
fai n563(c1[525],s1[526],c1[571],s1[572],c1[572]);
fai n564(c1[526],s1[527],c1[572],s1[573],c1[573]);
fai n565(c1[527],s1[528],c1[573],s1[574],c1[574]);
fai n566(c1[528],s1[529],c1[574],s1[575],c1[575]);
fai n567(c1[529],s1[530],c1[575],s1[576],c1[576]);
fai n568(c1[530],s1[531],c1[576],s1[577],c1[577]);
fai n569(c1[531],s1[532],c1[577],s1[578],c1[578]);
fai n570(c1[532],s1[533],c1[578],s1[579],c1[579]);
fai n571(c1[533],s1[534],c1[579],s1[580],c1[580]); 
fai n5213(c1[534],s1[535],c1[580],s1[581],c1[581]); 
fai n5222(c1[535],s1[536],c1[581],s1[582],c1[582]); 
ha n5223(c1[536],c1[582],s1[583],c1[583]);

assign y[0]=w[0][0];
assign y[1]=s1[537];
assign y[2]=s1[538];
assign y[3]=s1[539];
assign y[4]=s1[540];
assign y[5]=s1[541];
assign y[6]=s1[542];
assign y[7]=s1[543];
assign y[8]=s1[544];
assign y[9]=s1[545];
assign y[10]=s1[546];
assign y[11]=s1[547];
assign y[12]=s1[548];
assign y[13]=s1[549];
assign y[14]=s1[550];
assign y[15]=s1[551];
assign y[16]=s1[552];
assign y[17]=s1[553];
assign y[18]=s1[554];
assign y[19]=s1[555];
assign y[20]=s1[556];
assign y[21]=s1[557];
assign y[22]=s1[558];
assign y[23]=s1[559];
assign y[24]=s1[560];
assign y[25]=s1[561];
assign y[26]=s1[562];
assign y[27]=s1[563];
assign y[28]=s1[564];
assign y[29]=s1[565];
assign y[30]=s1[566];
assign y[31]=s1[567];
assign y[32]=s1[568];
assign y[33]=s1[569];
assign y[34]=s1[570];
assign y[35]=s1[571];
assign y[36]=s1[572];
assign y[37]=s1[573];
assign y[38]=s1[574];
assign y[39]=s1[575];
assign y[40]=s1[576];
assign y[41]=s1[577];
assign y[42]=s1[578];
assign y[43]=s1[579];
assign y[44]=s1[580];
assign y[45]=s1[581];
assign y[46]=s1[582];
assign y[47]=s1[583];
assign y[48]=c1[583]; 

endmodule

module ha(input x,y,output s,c 
    ); 
assign s=x^y; 
assign c=x&y; 
 
endmodule

module fai(input p,q,r,output t,u 
    ); 
assign t=p^q^r; 
assign u=p&q|q&r|p&r; 
 
endmodule 