Return-Path: <19558058@students.latrobe.edu.au>
X-Greylist: delayed 384 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 26 Sep 2019 04:54:00 UTC
Received: from au-smtp-delivery-111.mimecast.com
	(au-smtp-delivery-111.mimecast.com [180.189.28.111])
	by mail.openembedded.org (Postfix) with ESMTP id 095937EC5D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 04:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=students.latrobe.edu.au;
	s=mimecast20170607; t=1569473641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PWfvMDbaNxGjZtLHJmOsRi7slgTtwRTf4/uY+iw19CA=;
	b=Gy/DfuF7fLDP1xJLINe/a2Epva1O84vMekGcueKdmNhfcZUFxqtYkqgzXbuay5TqR9NVm2
	qpLZnFEm/NAi0Hon+KKcaTfNTCESdgvGmBI3cQL/CCsISObbkYFNLSAJAINZdeE7RfYqwD
	1sfF/qmGrG3QfeuS8MOtDOHD1P9xLgcDgedVHjZ/cGETCT178Ai16Dh1xTxeVsQC6PUkR2
	OFbtCm1bOgH/nd2Gxjxd6hYd3xI29naffE6QuG5Xigwmvv30RvN7LPh98CSPNtpcAAktef
	DzffuR0De8F0KT/8BwBvu9zJNI+lNVm3ugGNIny95tQM4U76hycUpwO2cI8Z8g==
Received: from AUS01-SY3-obe.outbound.protection.outlook.com
	(mail-sy3aus01lp2053.outbound.protection.outlook.com [104.47.117.53])
	(Using TLS) by relay.mimecast.com with ESMTP id
	au-mta-39-96N0D4IrMU2SSZZGlNonvQ-1; Thu, 26 Sep 2019 14:47:34 +1000
Received: from MEAPR01MB4199.ausprd01.prod.outlook.com (20.178.177.12) by
	MEAPR01MB2358.ausprd01.prod.outlook.com (52.134.200.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2284.22; Thu, 26 Sep 2019 04:47:30 +0000
Received: from MEAPR01MB4199.ausprd01.prod.outlook.com
	([fe80::8468:146a:88b8:9699]) by
	MEAPR01MB4199.ausprd01.prod.outlook.com
	([fe80::8468:146a:88b8:9699%2]) with mapi id 15.20.2284.023;
	Thu, 26 Sep 2019 04:47:29 +0000
From: SHOAIB MUHAMMAD <19558058@students.latrobe.edu.au>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Bitbake Error
Thread-Index: AQHVdCVmfiiOW8r0I0q187w8tK3/hQ==
Date: Thu, 26 Sep 2019 04:47:29 +0000
Message-ID: <MEAPR01MB419977871A4644D3FA437302C0860@MEAPR01MB4199.ausprd01.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [49.199.58.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f26345d-c01d-4696-98bc-08d7423ca334
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:MEAPR01MB2358; 
x-ms-traffictypediagnostic: MEAPR01MB2358:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MEAPR01MB2358AF3DA30ED7C4DF055EF8C0860@MEAPR01MB2358.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39860400002)(366004)(136003)(376002)(396003)(346002)(199004)(189003)(8936002)(105004)(33656002)(2501003)(5660300002)(71200400001)(66946007)(66556008)(81156014)(7116003)(14444005)(2351001)(7066003)(71190400001)(7736002)(14454004)(486006)(86362001)(52536014)(76116006)(256004)(6116002)(3846002)(236005)(606006)(6306002)(6436002)(9686003)(5640700003)(30864003)(107886003)(66446008)(74316002)(64756008)(66476007)(6506007)(16799955002)(6916009)(3480700005)(54896002)(88552002)(316002)(478600001)(786003)(2906002)(102836004)(55016002)(15188155005)(221733001)(7696005)(347745004)(476003)(8676002)(25786009)(19627405001)(4326008)(186003)(66066001)(81166006)(99286004)(26005)(81782002)(81742002)(19623215001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MEAPR01MB2358;
	H:MEAPR01MB4199.ausprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0g660Xp2URgCcGEZOq3LYQ/Lp0cCuCPM3DxHSGllr3NPQHn0/rraqPRHYsztRsDDTTHa4aF+0QlwCvJN924KauZwe0FKTlQQplF49hiiQ9AF77WusjhAme2oIzzOOilxuoHRZCywmxo7AbBr05ak/Pu1WwHa+rhpUctwa691rBBJDnziF9561oyg5X/ebxa0I/fo6BPUrbCGgV15dFIQAsmVpmWdguO+mBRLoBfm842F2fRRm1VSQZ2fyLqwV5hl0azoD/Cav31rtx3J8r3VBV8tL2MVtvQULQNk7XcA9j/gZRcsTHhFv3JgeCBRK/IO6WsZfltBL1AupvGNP9d7GhMIH027DrLgFd0lyeR4OyuJD9zaWKScuTRu3i3niZ7JQ94Jl8sJu5IkY801cvwJOaKxElFsBwzO8d9sbgQC/yxUiSTWAJBwlk1zlJvusM7D
MIME-Version: 1.0
X-OriginatorOrg: students.latrobe.edu.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f26345d-c01d-4696-98bc-08d7423ca334
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 04:47:29.6560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9aee26d8-97c2-4fad-8900-96735f6dc73f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jd69whmJSq00Jke+UbTekMRFtV8TbpqYQBP4hKUaxm1551NDbQ/wyJRQ4TKI0q2HkhtJW4w9gGYJdKw7gp/QL8B2g4qr1BtvlS/7CHKZ6E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAPR01MB2358
X-MC-Unique: 96N0D4IrMU2SSZZGlNonvQ-1
X-Mimecast-Spam-Score: 0
X-Mailman-Approved-At: Thu, 26 Sep 2019 20:40:06 +0000
Cc: ADARSH KUMAR <19844172@students.latrobe.edu.au>
Subject: Bitbake Error
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 26 Sep 2019 04:54:01 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MEAPR01MB419977871A4644D3FA437302C0860MEAPR01MB4199ausp_"

--_000_MEAPR01MB419977871A4644D3FA437302C0860MEAPR01MB4199ausp_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Hi,

I have a VAR-SOM-AM43 Development Kit and I am following the instruction on=
 the Variscite Wiki: VarWiki<http://variwiki.com/index.php?title=3DVAR-SOM-=
AM43_Yocto_Krogoth_GS>

Upon executing the following script:

MACHINE=3Dvarsomam43 bitbake tisdk-rootfs-image

I receive the following error:

caruban@SolarCrucible:~/yocto_varsomam43/tisdk/build$ . conf/setenv
caruban@SolarCrucible:~/yocto_varsomam43/tisdk/build$ export PATH=3D/opt/gc=
c-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:$PATH
caruban@SolarCrucible:~/yocto_varsomam43/tisdk/build$ MACHINE=3Dvarsomam43 =
bitbake tisdk-rootfs-image
Parsing recipes: 100% |####################################################=
###################################################| Time: 00:04:15
Parsing of 2247 .bb files complete (0 cached, 2247 parsed). 2839 targets, 4=
93 skipped, 1 masked, 0 errors.
WARNING: No recipes available for:
  /home/caruban/yocto_varsomam43/tisdk/sources/meta-arago/meta-arago-distro=
/recipes-multimedia/libav/libav_9.16.bbappend
  /home/caruban/yocto_varsomam43/tisdk/sources/meta-processor-sdk/recipes-c=
ore/udev/udev_182.bbappend
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION        =3D "1.30.0"
BUILD_SYS         =3D "x86_64-linux"
NATIVELSBSTRING   =3D "Ubuntu-18.04"
TARGET_SYS        =3D "arm-linux-gnueabi"
MACHINE           =3D "varsomam43"
DISTRO            =3D "arago"
DISTRO_VERSION    =3D "2016.05"
TUNE_FEATURES     =3D "arm armv7a vfp thumb neon       callconvention-hard =
      cortexa9"
TARGET_FPU        =3D "hard"
meta-variscite-amx3 =3D "krogoth:a64a84e4764cccfb43ead1de4493939536c797fc"
meta-processor-sdk =3D "HEAD:1686d851985872f34ca3a2c30d4a0726a20a5c99"
meta-arago-distro
meta-arago-extras =3D "HEAD:36598b78a6d9fbe442f93111f64d3413c04418a8"
meta-qt5          =3D "HEAD:d715f2c1d340fa38f8a9860acc73de5e14a38b75"
meta-networking
meta-ruby
meta-python
meta-oe           =3D "HEAD:247b1267bbe95719cd4877d2d3cfbaf2a2f4865a"
meta-ti           =3D "HEAD:1ae0cadb1200d0007a779958e852a48379d42c26"
meta-linaro-toolchain =3D "HEAD:0f2a4dd08ab06768cc998fe3f7236e3942f4a2cc"
meta              =3D "HEAD:b0b91490e4ede61a302eb547da2cc65aa7da87ff"

NOTE: Preparing RunQueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
ERROR: gnu-config-native-20150728+gitAUTOINC+b576fa87c1-r0 do_unpack: Funct=
ion failed: Fetcher failure: Fetch command failed with exit code 128, outpu=
t:
fatal: the '--set-upstream' option is no longer supported. Please use '--tr=
ack' or '--set-upstream-to' instead.

ERROR: Logfile of failure stored in: /home/caruban/yocto_varsomam43/tisdk/b=
uild/arago-tmp-external-linaro-toolchain/work/x86_64-linux/gnu-config-nativ=
e/20150728+gitAUTOINC+b576fa87c1-r0/temp/log.do_unpack.6039
Log data follows:
| DEBUG: Executing python function do_unpack
| DEBUG: Executing python function base_do_unpack
| DEBUG: Running export DBUS_SESSION_BUS_ADDRESS=3D"unix:path=3D/run/user/1=
000/bus"; export SSH_AGENT_PID=3D"1487"; export SSH_AUTH_SOCK=3D"/run/user/=
1000/keyring/ssh"; export PATH=3D"/home/caruban/yocto_varsomam43/tisdk/sour=
ces/oe-core/scripts/native-intercept:/home/caruban/yocto_varsomam43/tisdk/s=
ources/oe-core/scripts:/home/caruban/yocto_varsomam43/tisdk/build/arago-tmp=
-external-linaro-toolchain/sysroots/x86_64-linux/usr/bin/x86_64-linux:/home=
/caruban/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/s=
ysroots/x86_64-linux/usr/bin:/home/caruban/yocto_varsomam43/tisdk/build/ara=
go-tmp-external-linaro-toolchain/sysroots/x86_64-linux/usr/sbin:/home/carub=
an/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroot=
s/x86_64-linux/usr/bin:/home/caruban/yocto_varsomam43/tisdk/build/arago-tmp=
-external-linaro-toolchain/sysroots/x86_64-linux/sbin:/home/caruban/yocto_v=
arsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroots/x86_64-l=
inux/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/opt/=
gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/home/caruban/yocto=
_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/yocto_varsomam43/ti=
sdk/sources/bitbake/bin:/home/caruban/yocto_varsomam43/tisdk/sources/oe-cor=
e/scripts:/home/caruban/yocto_varsomam43/tisdk/sources/bitbake/bin:/opt/gcc=
-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/opt/gcc-linaro-5.3.1-=
2016.05-x86_64_arm-linux-gnueabihf/bin:/home/caruban/yocto_varsomam43/tisdk=
/sources/oe-core/scripts:/home/caruban/yocto_varsomam43/tisdk/sources/bitba=
ke/bin:/home/caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts:/home/c=
aruban/yocto_varsomam43/tisdk/sources/bitbake/bin:/opt/gcc-linaro-5.3.1-201=
6.05-x86_64_arm-linux-gnueabihf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbi=
n:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"; export HOME=
=3D"/home/caruban"; git -c core.fsyncobjectfiles=3D0 clone -s -n /home/caru=
ban/yocto_dl/git2/git.sv.gnu.org.config.git/ /home/caruban/yocto_varsomam43=
/tisdk/build/arago-tmp-external-linaro-toolchain/work/x86_64-linux/gnu-conf=
ig-native/20150728+gitAUTOINC+b576fa87c1-r0/git/
| DEBUG: Running export DBUS_SESSION_BUS_ADDRESS=3D"unix:path=3D/run/user/1=
000/bus"; export SSH_AGENT_PID=3D"1487"; export SSH_AUTH_SOCK=3D"/run/user/=
1000/keyring/ssh"; export PATH=3D"/home/caruban/yocto_varsomam43/tisdk/sour=
ces/oe-core/scripts/native-intercept:/home/caruban/yocto_varsomam43/tisdk/s=
ources/oe-core/scripts:/home/caruban/yocto_varsomam43/tisdk/build/arago-tmp=
-external-linaro-toolchain/sysroots/x86_64-linux/usr/bin/x86_64-linux:/home=
/caruban/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/s=
ysroots/x86_64-linux/usr/bin:/home/caruban/yocto_varsomam43/tisdk/build/ara=
go-tmp-external-linaro-toolchain/sysroots/x86_64-linux/usr/sbin:/home/carub=
an/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroot=
s/x86_64-linux/usr/bin:/home/caruban/yocto_varsomam43/tisdk/build/arago-tmp=
-external-linaro-toolchain/sysroots/x86_64-linux/sbin:/home/caruban/yocto_v=
arsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroots/x86_64-l=
inux/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/opt/=
gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/home/caruban/yocto=
_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/yocto_varsomam43/ti=
sdk/sources/bitbake/bin:/home/caruban/yocto_varsomam43/tisdk/sources/oe-cor=
e/scripts:/home/caruban/yocto_varsomam43/tisdk/sources/bitbake/bin:/opt/gcc=
-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/opt/gcc-linaro-5.3.1-=
2016.05-x86_64_arm-linux-gnueabihf/bin:/home/caruban/yocto_varsomam43/tisdk=
/sources/oe-core/scripts:/home/caruban/yocto_varsomam43/tisdk/sources/bitba=
ke/bin:/home/caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts:/home/c=
aruban/yocto_varsomam43/tisdk/sources/bitbake/bin:/opt/gcc-linaro-5.3.1-201=
6.05-x86_64_arm-linux-gnueabihf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbi=
n:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"; export HOME=
=3D"/home/caruban"; git -c core.fsyncobjectfiles=3D0 remote set-url origin =
git://git.sv.gnu.org/config.git
| DEBUG: Running export DBUS_SESSION_BUS_ADDRESS=3D"unix:path=3D/run/user/1=
000/bus"; export SSH_AGENT_PID=3D"1487"; export SSH_AUTH_SOCK=3D"/run/user/=
1000/keyring/ssh"; export PATH=3D"/home/caruban/yocto_varsomam43/tisdk/sour=
ces/oe-core/scripts/native-intercept:/home/caruban/yocto_varsomam43/tisdk/s=
ources/oe-core/scripts:/home/caruban/yocto_varsomam43/tisdk/build/arago-tmp=
-external-linaro-toolchain/sysroots/x86_64-linux/usr/bin/x86_64-linux:/home=
/caruban/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/s=
ysroots/x86_64-linux/usr/bin:/home/caruban/yocto_varsomam43/tisdk/build/ara=
go-tmp-external-linaro-toolchain/sysroots/x86_64-linux/usr/sbin:/home/carub=
an/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroot=
s/x86_64-linux/usr/bin:/home/caruban/yocto_varsomam43/tisdk/build/arago-tmp=
-external-linaro-toolchain/sysroots/x86_64-linux/sbin:/home/caruban/yocto_v=
arsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroots/x86_64-l=
inux/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/opt/=
gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/home/caruban/yocto=
_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/yocto_varsomam43/ti=
sdk/sources/bitbake/bin:/home/caruban/yocto_varsomam43/tisdk/sources/oe-cor=
e/scripts:/home/caruban/yocto_varsomam43/tisdk/sources/bitbake/bin:/opt/gcc=
-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/opt/gcc-linaro-5.3.1-=
2016.05-x86_64_arm-linux-gnueabihf/bin:/home/caruban/yocto_varsomam43/tisdk=
/sources/oe-core/scripts:/home/caruban/yocto_varsomam43/tisdk/sources/bitba=
ke/bin:/home/caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts:/home/c=
aruban/yocto_varsomam43/tisdk/sources/bitbake/bin:/opt/gcc-linaro-5.3.1-201=
6.05-x86_64_arm-linux-gnueabihf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbi=
n:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"; export HOME=
=3D"/home/caruban"; git -c core.fsyncobjectfiles=3D0 checkout -B master b57=
6fa87c140b824466ef1638e945e87dc5c0343
| DEBUG: Running export DBUS_SESSION_BUS_ADDRESS=3D"unix:path=3D/run/user/1=
000/bus"; export SSH_AGENT_PID=3D"1487"; export SSH_AUTH_SOCK=3D"/run/user/=
1000/keyring/ssh"; export PATH=3D"/home/caruban/yocto_varsomam43/tisdk/sour=
ces/oe-core/scripts/native-intercept:/home/caruban/yocto_varsomam43/tisdk/s=
ources/oe-core/scripts:/home/caruban/yocto_varsomam43/tisdk/build/arago-tmp=
-external-linaro-toolchain/sysroots/x86_64-linux/usr/bin/x86_64-linux:/home=
/caruban/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/s=
ysroots/x86_64-linux/usr/bin:/home/caruban/yocto_varsomam43/tisdk/build/ara=
go-tmp-external-linaro-toolchain/sysroots/x86_64-linux/usr/sbin:/home/carub=
an/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroot=
s/x86_64-linux/usr/bin:/home/caruban/yocto_varsomam43/tisdk/build/arago-tmp=
-external-linaro-toolchain/sysroots/x86_64-linux/sbin:/home/caruban/yocto_v=
arsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroots/x86_64-l=
inux/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/opt/=
gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/home/caruban/yocto=
_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/yocto_varsomam43/ti=
sdk/sources/bitbake/bin:/home/caruban/yocto_varsomam43/tisdk/sources/oe-cor=
e/scripts:/home/caruban/yocto_varsomam43/tisdk/sources/bitbake/bin:/opt/gcc=
-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/opt/gcc-linaro-5.3.1-=
2016.05-x86_64_arm-linux-gnueabihf/bin:/home/caruban/yocto_varsomam43/tisdk=
/sources/oe-core/scripts:/home/caruban/yocto_varsomam43/tisdk/sources/bitba=
ke/bin:/home/caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts:/home/c=
aruban/yocto_varsomam43/tisdk/sources/bitbake/bin:/opt/gcc-linaro-5.3.1-201=
6.05-x86_64_arm-linux-gnueabihf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbi=
n:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"; export HOME=
=3D"/home/caruban"; git -c core.fsyncobjectfiles=3D0 branch --set-upstream =
master origin/master
| DEBUG: Python function base_do_unpack finished
| DEBUG: Python function do_unpack finished
| ERROR: Function failed: Fetcher failure: Fetch command failed with exit c=
ode 128, output:
| fatal: the '--set-upstream' option is no longer supported. Please use '--=
track' or '--set-upstream-to' instead.
|
ERROR: Task 743 (virtual:native:/home/caruban/yocto_varsomam43/tisdk/source=
s/oe-core/meta/recipes-devtools/gnu-config/gnu-config_git.bb, do_unpack) fa=
iled with exit code '1'
NOTE: Tasks Summary: Attempted 10 tasks of which 7 didn't need to be rerun =
and 1 failed.

Summary: 1 task failed:
  virtual:native:/home/caruban/yocto_varsomam43/tisdk/sources/oe-core/meta/=
recipes-devtools/gnu-config/gnu-config_git.bb, do_unpack
Summary: There was 1 WARNING message shown.
Summary: There was 1 ERROR message shown, returning a non-zero exit code.


It seems that a command is outdated with the current system I am using. I a=
m running a Linux 18.04 LTS on the host PC.

Is there any way to fix this?


Kind regards,

Shoaib


--_000_MEAPR01MB419977871A4644D3FA437302C0860MEAPR01MB4199ausp_
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<p>Hi,</p>
<p></p>
<p>I have a VAR-SOM-AM43 Development Kit and I am following the instruction=
 on the Variscite Wiki:
<a href=3D"http://variwiki.com/index.php?title=3DVAR-SOM-AM43_Yocto_Krogoth=
_GS">VarWiki</a></p>
<p>Upon executing the following script:</p>
<div style=3D"max-width: 100%; overflow: auto; max-height: none">
<pre><strong>MACHINE=3Dvarsomam43 bitbake tisdk-rootfs-image<br></strong></=
pre>
</div>
<p>I receive the following error:</p>
<p>caruban@SolarCrucible:~/yocto_varsomam43/tisdk/build$ . conf/setenv<br>
caruban@SolarCrucible:~/yocto_varsomam43/tisdk/build$ export PATH=3D/opt/gc=
c-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:$PATH<br>
caruban@SolarCrucible:~/yocto_varsomam43/tisdk/build$ MACHINE=3Dvarsomam43 =
bitbake tisdk-rootfs-image<br>
Parsing recipes: 100% |####################################################=
###################################################| Time: 00:04:15<br>
Parsing of 2247 .bb files complete (0 cached, 2247 parsed). 2839 targets, 4=
93 skipped, 1 masked, 0 errors.<br>
<span style=3D"color:#ff9900">WARNING: No recipes available for:</span><br>
<span style=3D"color:#ff9900">&nbsp; /home/caruban/yocto_varsomam43/tisdk/s=
ources/meta-arago/meta-arago-distro/recipes-multimedia/libav/libav_9.16.bba=
ppend</span><br>
<span style=3D"color:#ff9900">&nbsp; /home/caruban/yocto_varsomam43/tisdk/s=
ources/meta-processor-sdk/recipes-core/udev/udev_182.bbappend</span><br>
NOTE: Resolving any missing task queue dependencies<br>
<br>
Build Configuration:<br>
BB_VERSION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;1.30.0&quot;=
<br>
BUILD_SYS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;x86_64-=
linux&quot;<br>
NATIVELSBSTRING&nbsp;&nbsp; =3D &quot;Ubuntu-18.04&quot;<br>
TARGET_SYS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;arm-linux-gn=
ueabi&quot;<br>
MACHINE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &qu=
ot;varsomam43&quot;<br>
DISTRO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D &quot;arago&quot;<br>
DISTRO_VERSION&nbsp;&nbsp;&nbsp; =3D &quot;2016.05&quot;<br>
TUNE_FEATURES&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;arm armv7a vfp thumb neon&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; callconvention-hard&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; cortexa9&quot;<br>
TARGET_FPU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;hard&quot;<b=
r>
meta-variscite-amx3 =3D &quot;krogoth:a64a84e4764cccfb43ead1de4493939536c79=
7fc&quot;<br>
meta-processor-sdk =3D &quot;HEAD:1686d851985872f34ca3a2c30d4a0726a20a5c99&=
quot;<br>
meta-arago-distro <br>
meta-arago-extras =3D &quot;HEAD:36598b78a6d9fbe442f93111f64d3413c04418a8&q=
uot;<br>
meta-qt5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;HE=
AD:d715f2c1d340fa38f8a9860acc73de5e14a38b75&quot;<br>
meta-networking&nbsp; &nbsp;<br>
meta-ruby&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<br>
meta-python&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<br>
meta-oe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &qu=
ot;HEAD:247b1267bbe95719cd4877d2d3cfbaf2a2f4865a&quot;<br>
meta-ti&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &qu=
ot;HEAD:1ae0cadb1200d0007a779958e852a48379d42c26&quot;<br>
meta-linaro-toolchain =3D &quot;HEAD:0f2a4dd08ab06768cc998fe3f7236e3942f4a2=
cc&quot;<br>
meta&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D &quot;HEAD:b0b91490e4ede61a302eb547da2cc65aa7da87ff&quot;<br>
<br>
NOTE: Preparing RunQueue<br>
NOTE: Executing SetScene Tasks<br>
NOTE: Executing RunQueue Tasks<br>
<span style=3D"color:#ff0000">ERROR: gnu-config-native-20150728&#43;gitAUTO=
INC&#43;b576fa87c1-r0 do_unpack: Function failed: Fetcher failure: Fetch co=
mmand failed with exit code 128, output:</span><br>
<span style=3D"color:#ff0000">fatal: the '--set-upstream' option is no long=
er supported. Please use '--track' or '--set-upstream-to' instead.</span><b=
r>
<br>
ERROR: Logfile of failure stored in: /home/caruban/yocto_varsomam43/tisdk/b=
uild/arago-tmp-external-linaro-toolchain/work/x86_64-linux/gnu-config-nativ=
e/20150728&#43;gitAUTOINC&#43;b576fa87c1-r0/temp/log.do_unpack.6039<br>
Log data follows:<br>
| DEBUG: Executing python function do_unpack<br>
| DEBUG: Executing python function base_do_unpack<br>
| DEBUG: Running export DBUS_SESSION_BUS_ADDRESS=3D&quot;unix:path=3D/run/u=
ser/1000/bus&quot;; export SSH_AGENT_PID=3D&quot;1487&quot;; export SSH_AUT=
H_SOCK=3D&quot;/run/user/1000/keyring/ssh&quot;; export PATH=3D&quot;/home/=
caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts/native-intercept:/ho=
me/caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/yoc=
to_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroots/x86_=
64-linux/usr/bin/x86_64-linux:/home/caruban/yocto_varsomam43/tisdk/build/ar=
ago-tmp-external-linaro-toolchain/sysroots/x86_64-linux/usr/bin:/home/carub=
an/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroot=
s/x86_64-linux/usr/sbin:/home/caruban/yocto_varsomam43/tisdk/build/arago-tm=
p-external-linaro-toolchain/sysroots/x86_64-linux/usr/bin:/home/caruban/yoc=
to_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroots/x86_=
64-linux/sbin:/home/caruban/yocto_varsomam43/tisdk/build/arago-tmp-external=
-linaro-toolchain/sysroots/x86_64-linux/bin:/opt/gcc-linaro-5.3.1-2016.05-x=
86_64_arm-linux-gnueabihf/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linu=
x-gnueabihf/bin:/home/caruban/yocto_varsomam43/tisdk/sources/oe-core/script=
s:/home/caruban/yocto_varsomam43/tisdk/sources/bitbake/bin:/home/caruban/yo=
cto_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/yocto_varsomam43=
/tisdk/sources/bitbake/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-g=
nueabihf/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/=
home/caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/y=
octo_varsomam43/tisdk/sources/bitbake/bin:/home/caruban/yocto_varsomam43/ti=
sdk/sources/oe-core/scripts:/home/caruban/yocto_varsomam43/tisdk/sources/bi=
tbake/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/usr=
/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/lo=
cal/games:/snap/bin&quot;;
 export HOME=3D&quot;/home/caruban&quot;; git -c core.fsyncobjectfiles=3D0 =
clone -s -n /home/caruban/yocto_dl/git2/git.sv.gnu.org.config.git/ /home/ca=
ruban/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/work=
/x86_64-linux/gnu-config-native/20150728&#43;gitAUTOINC&#43;b576fa87c1-r0/g=
it/<br>
| DEBUG: Running export DBUS_SESSION_BUS_ADDRESS=3D&quot;unix:path=3D/run/u=
ser/1000/bus&quot;; export SSH_AGENT_PID=3D&quot;1487&quot;; export SSH_AUT=
H_SOCK=3D&quot;/run/user/1000/keyring/ssh&quot;; export PATH=3D&quot;/home/=
caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts/native-intercept:/ho=
me/caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/yoc=
to_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroots/x86_=
64-linux/usr/bin/x86_64-linux:/home/caruban/yocto_varsomam43/tisdk/build/ar=
ago-tmp-external-linaro-toolchain/sysroots/x86_64-linux/usr/bin:/home/carub=
an/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroot=
s/x86_64-linux/usr/sbin:/home/caruban/yocto_varsomam43/tisdk/build/arago-tm=
p-external-linaro-toolchain/sysroots/x86_64-linux/usr/bin:/home/caruban/yoc=
to_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroots/x86_=
64-linux/sbin:/home/caruban/yocto_varsomam43/tisdk/build/arago-tmp-external=
-linaro-toolchain/sysroots/x86_64-linux/bin:/opt/gcc-linaro-5.3.1-2016.05-x=
86_64_arm-linux-gnueabihf/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linu=
x-gnueabihf/bin:/home/caruban/yocto_varsomam43/tisdk/sources/oe-core/script=
s:/home/caruban/yocto_varsomam43/tisdk/sources/bitbake/bin:/home/caruban/yo=
cto_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/yocto_varsomam43=
/tisdk/sources/bitbake/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-g=
nueabihf/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/=
home/caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/y=
octo_varsomam43/tisdk/sources/bitbake/bin:/home/caruban/yocto_varsomam43/ti=
sdk/sources/oe-core/scripts:/home/caruban/yocto_varsomam43/tisdk/sources/bi=
tbake/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/usr=
/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/lo=
cal/games:/snap/bin&quot;;
 export HOME=3D&quot;/home/caruban&quot;; git -c core.fsyncobjectfiles=3D0 =
remote set-url origin git://git.sv.gnu.org/config.git<br>
| DEBUG: Running export DBUS_SESSION_BUS_ADDRESS=3D&quot;unix:path=3D/run/u=
ser/1000/bus&quot;; export SSH_AGENT_PID=3D&quot;1487&quot;; export SSH_AUT=
H_SOCK=3D&quot;/run/user/1000/keyring/ssh&quot;; export PATH=3D&quot;/home/=
caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts/native-intercept:/ho=
me/caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/yoc=
to_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroots/x86_=
64-linux/usr/bin/x86_64-linux:/home/caruban/yocto_varsomam43/tisdk/build/ar=
ago-tmp-external-linaro-toolchain/sysroots/x86_64-linux/usr/bin:/home/carub=
an/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroot=
s/x86_64-linux/usr/sbin:/home/caruban/yocto_varsomam43/tisdk/build/arago-tm=
p-external-linaro-toolchain/sysroots/x86_64-linux/usr/bin:/home/caruban/yoc=
to_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroots/x86_=
64-linux/sbin:/home/caruban/yocto_varsomam43/tisdk/build/arago-tmp-external=
-linaro-toolchain/sysroots/x86_64-linux/bin:/opt/gcc-linaro-5.3.1-2016.05-x=
86_64_arm-linux-gnueabihf/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linu=
x-gnueabihf/bin:/home/caruban/yocto_varsomam43/tisdk/sources/oe-core/script=
s:/home/caruban/yocto_varsomam43/tisdk/sources/bitbake/bin:/home/caruban/yo=
cto_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/yocto_varsomam43=
/tisdk/sources/bitbake/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-g=
nueabihf/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/=
home/caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/y=
octo_varsomam43/tisdk/sources/bitbake/bin:/home/caruban/yocto_varsomam43/ti=
sdk/sources/oe-core/scripts:/home/caruban/yocto_varsomam43/tisdk/sources/bi=
tbake/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/usr=
/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/lo=
cal/games:/snap/bin&quot;;
 export HOME=3D&quot;/home/caruban&quot;; git -c core.fsyncobjectfiles=3D0 =
checkout -B master b576fa87c140b824466ef1638e945e87dc5c0343<br>
| DEBUG: Running export DBUS_SESSION_BUS_ADDRESS=3D&quot;unix:path=3D/run/u=
ser/1000/bus&quot;; export SSH_AGENT_PID=3D&quot;1487&quot;; export SSH_AUT=
H_SOCK=3D&quot;/run/user/1000/keyring/ssh&quot;; export PATH=3D&quot;/home/=
caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts/native-intercept:/ho=
me/caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/yoc=
to_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroots/x86_=
64-linux/usr/bin/x86_64-linux:/home/caruban/yocto_varsomam43/tisdk/build/ar=
ago-tmp-external-linaro-toolchain/sysroots/x86_64-linux/usr/bin:/home/carub=
an/yocto_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroot=
s/x86_64-linux/usr/sbin:/home/caruban/yocto_varsomam43/tisdk/build/arago-tm=
p-external-linaro-toolchain/sysroots/x86_64-linux/usr/bin:/home/caruban/yoc=
to_varsomam43/tisdk/build/arago-tmp-external-linaro-toolchain/sysroots/x86_=
64-linux/sbin:/home/caruban/yocto_varsomam43/tisdk/build/arago-tmp-external=
-linaro-toolchain/sysroots/x86_64-linux/bin:/opt/gcc-linaro-5.3.1-2016.05-x=
86_64_arm-linux-gnueabihf/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linu=
x-gnueabihf/bin:/home/caruban/yocto_varsomam43/tisdk/sources/oe-core/script=
s:/home/caruban/yocto_varsomam43/tisdk/sources/bitbake/bin:/home/caruban/yo=
cto_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/yocto_varsomam43=
/tisdk/sources/bitbake/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-g=
nueabihf/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/=
home/caruban/yocto_varsomam43/tisdk/sources/oe-core/scripts:/home/caruban/y=
octo_varsomam43/tisdk/sources/bitbake/bin:/home/caruban/yocto_varsomam43/ti=
sdk/sources/oe-core/scripts:/home/caruban/yocto_varsomam43/tisdk/sources/bi=
tbake/bin:/opt/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin:/usr=
/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/lo=
cal/games:/snap/bin&quot;;
 export HOME=3D&quot;/home/caruban&quot;; git -c core.fsyncobjectfiles=3D0 =
branch --set-upstream master origin/master<br>
| DEBUG: Python function base_do_unpack finished<br>
| DEBUG: Python function do_unpack finished<br>
|<span style=3D"color:#ff0000"> ERROR: Function failed: Fetcher failure: Fe=
tch command failed with exit code 128, output:</span><br>
<span style=3D"color:#ff0000">| fatal: the '--set-upstream' option is no lo=
nger supported. Please use '--track' or '--set-upstream-to' instead.</span>=
<br>
<span style=3D"color:#ff0000">| </span><br>
<span style=3D"color:#ff0000">ERROR: Task 743 (virtual:native:/home/caruban=
/yocto_varsomam43/tisdk/sources/oe-core/meta/recipes-devtools/gnu-config/gn=
u-config_git.bb, do_unpack) failed with exit code '1'</span><br>
<span style=3D"color:#ff0000">NOTE: Tasks Summary: Attempted 10 tasks of wh=
ich 7 didn't need to be rerun and 1 failed.</span><br>
<br>
Summary: 1 task failed:<br>
&nbsp; virtual:native:/home/caruban/yocto_varsomam43/tisdk/sources/oe-core/=
meta/recipes-devtools/gnu-config/gnu-config_git.bb, do_unpack<br>
Summary: There was 1 WARNING message shown.<br>
Summary: There was 1 ERROR message shown, returning a non-zero exit code.<b=
r>
<br>
</p>
<p>It seems that a command is outdated with the current system I am using. =
I am running a Linux 18.04 LTS on the host PC.</p>
<p>Is there any way to fix this?</p>
<p><br>
</p>
<p>Kind regards,</p>
<p>Shoaib</p>
<br>
</div>
</body>
</html>

--_000_MEAPR01MB419977871A4644D3FA437302C0860MEAPR01MB4199ausp_--
