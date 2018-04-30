Return-Path: <luis_martins_5@hotmail.com>
X-Greylist: delayed 21549 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 01 May 2018 03:27:34 UTC
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-oln040092064015.outbound.protection.outlook.com [40.92.64.15])
	by mail.openembedded.org (Postfix) with ESMTP id 992166011A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 May 2018 03:27:34 +0000 (UTC)
Received: from DB5EUR01HT106.eop-EUR01.prod.protection.outlook.com
	(2a01:111:e400:7e1a::309) by
	HE1EUR01HT111.eop-EUR01.prod.protection.outlook.com
	(2a01:111:e400:7e18::314) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.715.13;
	Mon, 30 Apr 2018 17:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=Hn1T20cY9PhplTjo3Lp6A+txOMt0+c1FNABhZ09VhUY=;
	b=J54FA9RcNk+rGgacgn8G5r4pEN3E3t0wqRukIAOyVOsqDP5irXIZU3IqF259loOGrZcCRrZWNfIZtPA/L17DQ8ofB5fv6ZrMLCPgAyBKiaSW+oJ5uKfCA0FSBEi+v2fz3LvCbd0DSdl9C2XA+UqehJsVFxNuzWngijf8I5IKTNa0BYzur2cL5Eu548suy2ZExYCzK4pGbI51HM/bRd+G9Ks8smu8VVfUp0GPbDhbXKif5J4rW6wKoC//bvSb5E1Tvc4J9Ag8R9e56ArUGXAiUKMQPutxdqezpKS6SD6XNfoRiY3SCBjUy5x9rMt8mGKttZvI6jLNZr55EszzExkWcA==
Received: from DB5EUR01FT046.eop-EUR01.prod.protection.outlook.com
	(10.152.4.60) by DB5EUR01HT106.eop-EUR01.prod.protection.outlook.com
	(10.152.5.53) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.20.715.13;
	Mon, 30 Apr 2018 13:37:47 +0000
Received: from AM5PR0902MB2034.eurprd09.prod.outlook.com (10.152.4.55) by
	DB5EUR01FT046.mail.protection.outlook.com (10.152.5.231) with Microsoft
	SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
	15.20.715.13 via Frontend Transport; Mon, 30 Apr 2018 13:37:47 +0000
Received: from AM5PR0902MB2034.eurprd09.prod.outlook.com
	([fe80::8c19:7741:8460:935]) by
	AM5PR0902MB2034.eurprd09.prod.outlook.com
	([fe80::8c19:7741:8460:935%13]) with mapi id 15.20.0715.018;
	Mon, 30 Apr 2018 13:37:47 +0000
From: Luis Martins <luis_martins_5@hotmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Help with Bitbake: (bitbake-layers show-recipes)
Thread-Index: AQHT4Ihs09h7l6k27UWVrCqo08/zEg==
Date: Mon, 30 Apr 2018 13:37:47 +0000
Message-ID: <AM5PR0902MB2034393B2A72AD72872D272B87820@AM5PR0902MB2034.eurprd09.prod.outlook.com>
Accept-Language: pt-PT, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:C58BB88BDD254292FA8783FD66BD584EBFCCC68C99781687721EAF3D2EF3B7BF;
	UpperCasedChecksum:17F19730CB3DE858A411A639950B87266466481FD107AC14F81BEBBD7C6E4058;
	SizeAsReceived:6979; Count:44
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [ayRkExx1CqXO62JtEWpt5/D60MwBK26e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB5EUR01HT106;
	7:n6YuQgFQN7tBRSnGIlcs3ry88uiQLvCsSQyGRxO9b0CPGv9WL3soPjUH4nctOkEB9YDyHYxt5bX10UAc9hNFk5PW6JJxDpKHVkx2sto5t5dmxfTZoVIDmONORNMelpVe42/+5w49c0ciTLFUCq8huoZyrpUnuen2Kv8iePaXfDijL0OU6f59P6wHDxBKSaRPcwds4dQQJkAnIDZA3xRJ8sg5eH36lpglxLQ5NAz0cWGm3853sV7zSHjGaVScO86E
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125374)(1603101448)(1701031045);
	SRVR:DB5EUR01HT106; 
X-MS-TrafficTypeDiagnostic: DB5EUR01HT106:|DB5EUR01HT106:|HE1EUR01HT111:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(444000031);
	SRVR:DB5EUR01HT106; BCL:0; PCL:0; RULEID:; SRVR:DB5EUR01HT106; 
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM; SFS:(7070007)(98901004); DIR:OUT;
	SFP:1901; SCL:1; SRVR:DB5EUR01HT106;
	H:AM5PR0902MB2034.eurprd09.prod.outlook.com; FPR:; SPF:None;
	LANG:; 
x-microsoft-antispam-message-info: f3McmsMem1/qz9xI4PfvbV5eR4WsiYV4FyL1iIs2iy6kRFIBZ+EJyxFTvxbh/s+ykFZS5jOyH/m7T/H9v2scYLe0snRi2JQ3P41rF0kq8Z74AIYr7er/CjdKJe9xKbR79oxHlq1SieD5ld0EwWhoAP1mErGOAVN+A5/W7QgVVJfqfBeoYjyEAc8wj7vC/2NG
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0ec11eff-3fd1-47fe-cfe2-08d5ae9f8f82
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec11eff-3fd1-47fe-cfe2-08d5ae9f8f82
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 13:37:47.2759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR01HT106
X-Microsoft-Exchange-Diagnostics: 1; HE1EUR01HT111;
	23:PDwcScUgcO9ZtBv/c8drZFvKgJINBHD0Y7Ok05YyNT2zWoY871Uo7WaT11k2J2HLHI/rRimAQ0N0TmfU8F5sRpElnD/qB7DLlkluLaxRbKC1tA1jzqt8WlXnjYQ++dVK68j3HOURh35oJtaH6DCKMA==
X-OriginatorOrg: hotmail.com
X-Mailman-Approved-At: Fri, 04 May 2018 15:27:04 +0000
Subject: Help with Bitbake: (bitbake-layers show-recipes)
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
X-List-Received-Date: Tue, 01 May 2018 03:27:35 -0000
X-Groupsio-MsgNum: 9283
Content-Language: pt-PT
Content-Type: multipart/related;
	boundary="_005_AM5PR0902MB2034393B2A72AD72872D272B87820AM5PR0902MB2034_";
	type="multipart/alternative"

--_005_AM5PR0902MB2034393B2A72AD72872D272B87820AM5PR0902MB2034_
Content-Type: multipart/alternative;
	boundary="_000_AM5PR0902MB2034393B2A72AD72872D272B87820AM5PR0902MB2034_"

--_000_AM5PR0902MB2034393B2A72AD72872D272B87820AM5PR0902MB2034_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Good afternoon,

The path that lead me to bitbake's recipe building is going to be presented=
 next, if the setup isn't important the warnings and errors are highlited i=
n green and you can skip it to there.

Similar to this thread<https://community.arm.com/dev-platforms/f/discussion=
s/157/issue-of-building-the-openembedded-filesysytem-from-source-for-juno>,=
 i'm having some hard time building the openembedded filesystem.
So far I have managed to follow this tutorial<https://community.arm.com/dev=
-platforms/w/docs/303/juno> until the "Booting the board" section. After ru=
nning the board some errors appear during the execution:

[cid:9fdceaa4-54de-4b86-bd56-dde464d64fb9]
[cid:01ae2961-d88c-4b0c-b656-f063a8de68cf]

This lead me to follow the "Addendum B: Building the OpenEmbedded filesysyt=
em from source"
(I thought this part was optional since in this section "Initialising a wor=
kspace" it says "The script will guide you through the process of initialis=
ing your workspace, automatically downloading all relevant source files and=
 required binaries.")

I executed this commands with no problems:


/* Create workspace */

/* WARNING: Do *not* create this as a subdirectory of the main Linaro Arm P=
latforms workspace created by `workspace_yy.mm' above */

$ mkdir openembedded

$ cd openembedded

$ export OE_HOME=3D`pwd`

$ git clone git://git.linaro.org/openembedded/jenkins-setup.git

$ cd $OE_HOME/jenkins-setup

$ git checkout release-YY.MM

$ cd $OE_HOME

$ sudo jenkins-setup/pre-build-root-install-dependencies.sh

$ jenkins-setup/init-and-build.sh

$ cd $OE_HOME/openembedded-core

$ ./oe-init-build-env

/* Add bitbake to your $PATH */

$ export PATH=3D$OE_HOME/openembedded-core/bitbake/bin:$PATH

But, after running this commands:


$ cd $OE_HOME/build

$ bitbake-layers show-recipes

I get the following Warnings and Errors (from the log file located in the d=
irectory /Desktop/openembedded/build/tmp-glibc/log/cooker)):


WARNING: /home/lfpm1993/Desktop/openembedded/meta-linaro/meta-ilp32/recipes=
-overlayed/glibc/glibc_2.26.bb: Exception during build_dependencies for do_=
install

WARNING: /home/lfpm1993/Desktop/openembedded/meta-linaro/meta-ilp32/recipes=
-overlayed/glibc/glibc_2.26.bb: Error during finalise of /home/lfpm1993/Des=
ktop/openembedded/meta-linaro/meta-ilp32/recipes-overlayed/glibc/glibc_2.26=
.bb

WARNING: /home/lfpm1993/Desktop/openembedded/meta-linaro/meta-ilp32/recipes=
-overlayed/glibc/glibc-initial_2.26.bb: Exception during build_dependencies=
 for do_install

WARNING: /home/lfpm1993/Desktop/openembedded/meta-linaro/meta-ilp32/recipes=
-overlayed/glibc/glibc-initial_2.26.bb: Error during finalise of /home/lfpm=
1993/Desktop/openembedded/meta-linaro/meta-ilp32/recipes-overlayed/glibc/gl=
ibc-initial_2.26.bb

ERROR: ExpansionError during parsing /home/lfpm1993/Desktop/openembedded/me=
ta-linaro/meta-ilp32/recipes-overlayed/glibc/glibc_2.26.bb

Traceback (most recent call last):

bb.data_smart.ExpansionError: Failure expanding variable do_install, expres=
sion was                oe_runmake install_root=3D/home/lfpm1993/Desktop/op=
enembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image instal=
l

                for r in bootparam_prot.x nlm_prot.x rstat.x       yppasswd=
.x klm_prot.x rex.x sm_inter.x mount.x           rusers.x spray.x nfs_prot.=
x rquota.x key_prot.x; do

                                h=3D`echo $r|sed -e's,\.x$,.h,'`

                                install -m 0644 /home/lfpm1993/Desktop/open=
embedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/git/sunrpc/rpc=
svc/$h /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-=
linux/glibc/2.26-r0/image//usr/include/rpcsvc/

                done

                install -Dm 0644 /home/lfpm1993/Desktop/openembedded/build/=
tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/etc/ld.so.conf /home/lfpm1993=
/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/i=
mage//etc/ld.so.conf

                install -d /home/lfpm1993/Desktop/openembedded/build/tmp-gl=
ibc/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/lib/locale

                make -f /home/lfpm1993/Desktop/openembedded/build/tmp-glibc=
/work/aarch64-oe-linux/glibc/2.26-r0/generate-supported.mk IN=3D"/home/lfpm=
1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-=
r0/git/localedata/SUPPORTED" OUT=3D"/home/lfpm1993/Desktop/openembedded/bui=
ld/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/SUPPORTED"

                # get rid of some broken files...

                for i in ; do

                                sed -i "/$i/d" /home/lfpm1993/Desktop/opene=
mbedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/SUPPORTED

                done

                rm -f /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/w=
ork/aarch64-oe-linux/glibc/2.26-r0/image/etc/rpc

                rm -rf /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/=
work/aarch64-oe-linux/glibc/2.26-r0/image/usr/share/zoneinfo

                rm -rf /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/=
work/aarch64-oe-linux/glibc/2.26-r0/image/usr/libexec/getconf

                rm -f /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/w=
ork/aarch64-oe-linux/glibc/2.26-r0/image/etc/localtime

                rm -rf /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/=
work/aarch64-oe-linux/glibc/2.26-r0/image/var


                # remove empty glibc dir

                if [ -d /home/lfpm1993/Desktop/openembedded/build/tmp-glibc=
/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/libexec ]; then

                                rmdir --ignore-fail-on-non-empty /home/lfpm=
1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-=
r0/image/usr/libexec

                fi


                oe_multilib_header bits/syscall.h bits/long-double.h


                if [ -f /home/lfpm1993/Desktop/openembedded/build/tmp-glibc=
/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/bin/mtrace ]; then

                                sed -i -e '1s,#!.*perl,#! /usr/bin/env perl=
,' -e '2s,exec.*perl,exec /usr/bin/env perl,' /home/lfpm1993/Desktop/openem=
bedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/bin/mt=
race

                fi

                rm -rf /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/=
work/aarch64-oe-linux/glibc/2.26-r0/image/usr/include/rpcsvc/rquota*

                # Info dir listing isn't interesting at this point so remov=
e it if it exists.

                if [ -e "/home/lfpm1993/Desktop/openembedded/build/tmp-glib=
c/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/share/info/dir" ]; then

                                rm -f /home/lfpm1993/Desktop/openembedded/b=
uild/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/share/info/dir

                fi


                if ! ${@bb.utils.contains('DISTRO_FEATURES', 'ldconfig', 't=
rue', 'false', d)}; then

                                # The distro doesn't want these files so le=
t's not install them

                                rm -f /home/lfpm1993/Desktop/openembedded/b=
uild/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/etc/ld.so.conf

                                rm -f /home/lfpm1993/Desktop/openembedded/b=
uild/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/sbin/ldconfig

                                # This directory will be empty now so remov=
e it too.

                                # But check whether it exists first, since =
it won't for glibc-initial.

                                if [ -d /home/lfpm1993/Desktop/openembedded=
/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/etc ]; then

                                               rmdir /home/lfpm1993/Desktop=
/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/etc

                                fi

                fi


                if echo glibc|grep -q "glibc-initial"; then

                                return

                fi


                install -d /home/lfpm1993/Desktop/openembedded/build/tmp-gl=
ibc/work/aarch64-oe-linux/glibc/2.26-r0/image/etc/init.d

                install -d /home/lfpm1993/Desktop/openembedded/build/tmp-gl=
ibc/work/aarch64-oe-linux/glibc/2.26-r0/image/var/db/nscd

                install -m 0755 /home/lfpm1993/Desktop/openembedded/build/t=
mp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/git/nscd/nscd.init /home/lfpm1=
993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r=
0/image/etc/init.d/nscd

                install -m 0755 /home/lfpm1993/Desktop/openembedded/build/t=
mp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/git/nscd/nscd.conf /home/lfpm1=
993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r=
0/image/etc/nscd.conf

                sed -i "s%daemon%start-stop-daemon --start --exec%g" /home/=
lfpm1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2=
.26-r0/image/etc/init.d/nscd


                install -d /home/lfpm1993/Desktop/openembedded/build/tmp-gl=
ibc/work/aarch64-oe-linux/glibc/2.26-r0/image/lib/systemd/system

                install -m 0644 /home/lfpm1993/Desktop/openembedded/build/t=
mp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/git/nscd/nscd.service /home/lf=
pm1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.2=
6-r0/image/lib/systemd/system/


                if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true=
', 'false', d)}; then

                                install -d /home/lfpm1993/Desktop/openembed=
ded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/etc/tmpfiles.=
d

                                echo "d /run/nscd 755 root root -" \

                                               > /home/lfpm1993/Desktop/ope=
nembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/etc/tmp=
files.d/nscd.conf

                else

                                install -d /home/lfpm1993/Desktop/openembed=
ded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/etc/default/v=
olatiles

                                echo "d root root 0755 /var/run/nscd none" =
\

                                               > /home/lfpm1993/Desktop/ope=
nembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/etc/def=
ault/volatiles/98_nscd

                fi

                if [ "/lib" !=3D "/lib" ] ; then

                                # The aarch64 ABI says the dynamic linker -=
must- be /lib/ld-linux-aarch64[_be].so.1

                                install -d /home/lfpm1993/Desktop/openembed=
ded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/lib

                                if [ -e /home/lfpm1993/Desktop/openembedded=
/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/lib/ld-linux-aar=
ch64.so.1 ]; then

                                                ln -s ${@base_path_relative=
('/lib', '/lib')}/ld-linux-aarch64.so.1 \

                                                               /home/lfpm19=
93/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0=
/image/lib/ld-linux-aarch64.so.1

                                elif [ -e /home/lfpm1993/Desktop/openembedd=
ed/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/lib/ld-linux-a=
arch64_be.so.1 ]; then

                                               ln -s ${@base_path_relative(=
'/lib', '/lib')}/ld-linux-aarch64_be.so.1 \

                                                               /home/lfpm19=
93/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0=
/image/lib/ld-linux-aarch64_be.so.1

                                fi

                fi

                do_install_armmultilib

which triggered exception NameError: name 'base_path_relative' is not defin=
ed


The only thing I changed from the original files was that I added "DISTRO_F=
EATURES_append =3D " virtualization"" to the /Desktop/openembedded/meta-vir=
tualization/layers.conf.
Executing uname -a gives:
Linux lfpm1993-virtual-machine 4.13.0-39-generic #44~16.04.1-Ubuntu SMP Thu=
 Apr 5 16:43:10 UTC 2018 x86_64 x86_64 x86_64

So, my question is how do I solve those warnings and errors?

Thanks for helping me,
Luis Martins



--_000_AM5PR0902MB2034393B2A72AD72872D272B87820AM5PR0902MB2034_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div>Good afternoon,</div>
<div><br>
</div>
<div>The path that lead me to bitbake's recipe building is going to be pres=
ented next, if the setup isn't important the warnings and errors are highli=
ted in green and you can skip it to there.</div>
<div><br>
</div>
<div>Similar to <a href=3D"https://community.arm.com/dev-platforms/f/discus=
sions/157/issue-of-building-the-openembedded-filesysytem-from-source-for-ju=
no" class=3D"OWAAutoLink" id=3D"LPlnk78529" previewremoved=3D"true">
this thread</a>, i'm having some hard time building the openembedded filesy=
stem.</div>
<div>So far I have managed to follow <a href=3D"https://community.arm.com/d=
ev-platforms/w/docs/303/juno" class=3D"OWAAutoLink" id=3D"LPlnk989448" prev=
iewremoved=3D"true">
this tutorial</a> until the &quot;Booting the board&quot; section. After ru=
nning the board some errors appear during the execution:</div>
<div><br>
</div>
<div><img size=3D"20030" contenttype=3D"image/png" id=3D"img849857" style=
=3D"max-width: 99.9%; user-select: none;" tabindex=3D"0" src=3D"cid:9fdceaa=
4-54de-4b86-bd56-dde464d64fb9"><br>
<img size=3D"5529" contenttype=3D"image/png" id=3D"img108347" style=3D"max-=
width: 99.9%; user-select: none;" tabindex=3D"0" src=3D"cid:01ae2961-d88c-4=
b0c-b656-f063a8de68cf"><br>
<br>
</div>
<div>This lead me to follow the <b><span style=3D"color: rgb(255, 0, 0);">&=
quot;Addendum B: Building the OpenEmbedded filesysytem from source&quot;&nb=
sp;</span></b></div>
<div>(I thought this part was optional since in this section &quot;Initiali=
sing a workspace&quot; it says &quot;The script will guide you through the =
process of initialising your workspace, automatically downloading all relev=
ant source files and required binaries.&quot;)</div>
<div><br>
</div>
<div>I executed this commands with no problems:</div>
<div><br>
</div>
<p></p>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>/* Create workspace */</b>=
</span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>/* WARNING: Do *not* creat=
e this as a subdirectory of the main Linaro Arm Platforms workspace created=
 by `workspace_yy.mm' above */</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>$ mkdir openembedded</b></=
span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>$ cd openembedded</b></spa=
n></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>$ export OE_HOME=3D`pwd`</=
b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>$ git clone git://git.lina=
ro.org/openembedded/jenkins-setup.git</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>$ cd $OE_HOME/jenkins-setu=
p</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>$ git checkout release-YY.=
MM</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>$ cd $OE_HOME</b></span></=
div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>$ sudo jenkins-setup/pre-b=
uild-root-install-dependencies.sh</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>$ jenkins-setup/init-and-b=
uild.sh</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>$ cd $OE_HOME/openembedded=
-core</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>$ ./oe-init-build-env</b><=
/span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>/* Add bitbake to your $PA=
TH */</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><b><span style=3D"color: rgb(0, 111, 201);">$ export PATH=3D$OE_HOME/o=
penembedded-core/bi</span></b><span style=3D"color: rgb(0, 111, 201);"><b>t=
bake/bin:$PATH</b></span></div>
<p></p>
</blockquote>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div></div>
<div><br>
</div>
<div>But, after running this commands:</div>
<div><br>
</div>
<p></p>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(0, 111, 201);"><b>$ cd $OE_HOME/build</b></s=
pan></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><b><span style=3D"color: rgb(0, 111, 201);">$ bitbake-layers show-reci=
p</span></b><span style=3D"color: rgb(0, 111, 201);"><b>es</b></span></div>
<p></p>
</blockquote>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><br>
</div>
<div>I get the following Warnings and Errors (from the log file located in =
the directory /Desktop/openembedded/build/tmp-glibc/log/cooker)):</div>
<div><br>
</div>
<p></p>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>WARNING: /home/lfpm1993/De=
sktop/openembedded/meta-linaro/meta-ilp32/recipes-overlayed/glibc/glibc_2.2=
6.bb: Exception during build_dependencies for do_install</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>WARNING: /home/lfpm1993/De=
sktop/openembedded/meta-linaro/meta-ilp32/recipes-overlayed/glibc/glibc_2.2=
6.bb: Error during finalise of /home/lfpm1993/Desktop/openembedded/meta-lin=
aro/meta-ilp32/recipes-overlayed/glibc/glibc_2.26.bb</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>WARNING: /home/lfpm1993/De=
sktop/openembedded/meta-linaro/meta-ilp32/recipes-overlayed/glibc/glibc-ini=
tial_2.26.bb: Exception during build_dependencies for do_install</b></span>=
</div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>WARNING: /home/lfpm1993/De=
sktop/openembedded/meta-linaro/meta-ilp32/recipes-overlayed/glibc/glibc-ini=
tial_2.26.bb: Error during finalise of /home/lfpm1993/Desktop/openembedded/=
meta-linaro/meta-ilp32/recipes-overlayed/glibc/glibc-initial_2.26.bb</b></s=
pan></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>ERROR: ExpansionError duri=
ng parsing /home/lfpm1993/Desktop/openembedded/meta-linaro/meta-ilp32/recip=
es-overlayed/glibc/glibc_2.26.bb</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>Traceback (most recent cal=
l last):</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>bb.data_smart.ExpansionErr=
or: Failure expanding variable do_install, expression was&nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; oe_runmake install_root=3D/home/lfpm1=
993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r=
0/image
 install</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; for r in bootparam_prot.x nlm_prot.x rstat.x&=
nbsp; &nbsp; &nbsp; &nbsp;yppasswd.x klm_prot.x rex.x sm_inter.x mount.x&nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rusers.x spray.x nfs_prot.x rquota.x =
key_prot.x; do</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; h=3D`echo $r|sed -e's,\.x$,.h,'`</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; install -m 0644 /home/lfpm1993/Desktop/openembedded/build/tmp-gl=
ibc/work/aarch64-oe-linux/glibc/2.26-r0/git/sunrpc/rpcsvc/$h /home/lfpm1993=
/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/i=
mage//usr/include/rpcsvc/</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; done</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; install -Dm 0644 /home/lfpm1993/Desktop/opene=
mbedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/etc/ld.so.conf =
/home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/g=
libc/2.26-r0/image//etc/ld.so.conf</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; install -d /home/lfpm1993/Desktop/openembedde=
d/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/lib/locale<=
/b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; make -f /home/lfpm1993/Desktop/openembedded/b=
uild/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/generate-supported.mk IN=
=3D&quot;/home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-o=
e-linux/glibc/2.26-r0/git/localedata/SUPPORTED&quot;
 OUT=3D&quot;/home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/aarch=
64-oe-linux/glibc/2.26-r0/SUPPORTED&quot;</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; # get rid of some broken files...</b></span><=
/div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; for i in ; do</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; sed -i &quot;/$i/d&quot; /home/lfpm1993/Desktop/openembedded/bui=
ld/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/SUPPORTED</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; done</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; rm -f /home/lfpm1993/Desktop/openembedded/bui=
ld/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/etc/rpc</b></span></=
div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; rm -rf /home/lfpm1993/Desktop/openembedded/bu=
ild/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/share/zoneinfo<=
/b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; rm -rf /home/lfpm1993/Desktop/openembedded/bu=
ild/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/libexec/getconf=
</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; rm -f /home/lfpm1993/Desktop/openembedded/bui=
ld/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/etc/localtime</b></s=
pan></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; rm -rf /home/lfpm1993/Desktop/openembedded/bu=
ild/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/var</b></span></div=
>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><b><br>
</b></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; # remove empty glibc dir</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; if [ -d /home/lfpm1993/Desktop/openembedded/b=
uild/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/libexec ]; the=
n</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; rmdir --ignore-fail-on-non-empty /home/lfpm1993/Desktop/openembe=
dded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/libexec<=
/b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; fi</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><b><br>
</b></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; oe_multilib_header bits/syscall.h bits/long-d=
ouble.h</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><b><br>
</b></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; if [ -f /home/lfpm1993/Desktop/openembedded/b=
uild/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/bin/mtrace ]; =
then</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; sed -i -e '1s,#!.*perl,#! /usr/bin/env perl,' -e '2s,exec.*perl,=
exec /usr/bin/env perl,' /home/lfpm1993/Desktop/openembedded/build/tmp-glib=
c/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/bin/mtrace</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; fi</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; rm -rf /home/lfpm1993/Desktop/openembedded/bu=
ild/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/include/rpcsvc/=
rquota*</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; # Info dir listing isn't interesting at this =
point so remove it if it exists.</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; if [ -e &quot;/home/lfpm1993/Desktop/openembe=
dded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/usr/share/in=
fo/dir&quot; ]; then</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; rm -f /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/a=
arch64-oe-linux/glibc/2.26-r0/image/usr/share/info/dir</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; fi</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><b><br>
</b></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; if ! ${@bb.utils.contains('DISTRO_FEATURES', =
'ldconfig', 'true', 'false', d)}; then</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; # The distro doesn't want these files so let's not install them<=
/b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; rm -f /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/a=
arch64-oe-linux/glibc/2.26-r0/image/etc/ld.so.conf</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; rm -f /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/a=
arch64-oe-linux/glibc/2.26-r0/image/sbin/ldconfig</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; # This directory will be empty now so remove it too.</b></span><=
/div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; # But check whether it exists first, since it won't for glibc-in=
itial.</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; if [ -d /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work=
/aarch64-oe-linux/glibc/2.26-r0/image/etc ]; then</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rmdir /ho=
me/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glib=
c/2.26-r0/image/etc</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; fi</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; fi</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><b><br>
</b></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; if echo glibc|grep -q &quot;glibc-initial&quo=
t;; then</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; return</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; fi</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><b><br>
</b></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; install -d /home/lfpm1993/Desktop/openembedde=
d/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/etc/init.d</b><=
/span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; install -d /home/lfpm1993/Desktop/openembedde=
d/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/var/db/nscd</b>=
</span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; install -m 0755 /home/lfpm1993/Desktop/openem=
bedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/git/nscd/nscd.in=
it /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linu=
x/glibc/2.26-r0/image/etc/init.d/nscd</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; install -m 0755 /home/lfpm1993/Desktop/openem=
bedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/git/nscd/nscd.co=
nf /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linu=
x/glibc/2.26-r0/image/etc/nscd.conf</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; sed -i &quot;s%daemon%start-stop-daemon --sta=
rt --exec%g&quot; /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/=
aarch64-oe-linux/glibc/2.26-r0/image/etc/init.d/nscd</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><b><br>
</b></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; install -d /home/lfpm1993/Desktop/openembedde=
d/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/lib/systemd/sys=
tem</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; install -m 0644 /home/lfpm1993/Desktop/openem=
bedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/git/nscd/nscd.se=
rvice /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-l=
inux/glibc/2.26-r0/image/lib/systemd/system/</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><b><br>
</b></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; if ${@bb.utils.contains('DISTRO_FEATURES', 's=
ystemd', 'true', 'false', d)}; then</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; install -d /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/w=
ork/aarch64-oe-linux/glibc/2.26-r0/image/etc/tmpfiles.d</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; echo &quot;d /run/nscd 755 root root -&quot; \</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&gt; /hom=
e/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc=
/2.26-r0/image/etc/tmpfiles.d/nscd.conf</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; else</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; install -d /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/w=
ork/aarch64-oe-linux/glibc/2.26-r0/image/etc/default/volatiles</b></span></=
div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; echo &quot;d root root 0755 /var/run/nscd none&quot; \</b></span=
></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&gt; /hom=
e/lfpm1993/Desktop/openembedded/build/tmp-glibc/work/aarch64-oe-linux/glibc=
/2.26-r0/image/etc/default/volatiles/98_nscd</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; fi</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; if [ &quot;/lib&quot; !=3D &quot;/lib&quot; ]=
 ; then</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; # The aarch64 ABI says the dynamic linker -must- be /lib/ld-linu=
x-aarch64[_be].so.1</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; install -d /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/w=
ork/aarch64-oe-linux/glibc/2.26-r0/image/lib</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; if [ -e /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/work=
/aarch64-oe-linux/glibc/2.26-r0/image/lib/ld-linux-aarch64.so.1 ]; then</b>=
</span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ln -s ${=
@base_path_relative('/lib', '/lib')}/ld-linux-aarch64.so.1 \</b></span></di=
v>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/home/lfpm1993/Desktop/opene=
mbedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/lib/ld-li=
nux-aarch64.so.1</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; elif [ -e /home/lfpm1993/Desktop/openembedded/build/tmp-glibc/wo=
rk/aarch64-oe-linux/glibc/2.26-r0/image/lib/ld-linux-aarch64_be.so.1 ]; the=
n</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ln -s ${@=
base_path_relative('/lib', '/lib')}/ld-linux-aarch64_be.so.1 \</b></span></=
div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/home/lfpm1993/Desktop/opene=
mbedded/build/tmp-glibc/work/aarch64-oe-linux/glibc/2.26-r0/image/lib/ld-li=
nux-aarch64_be.so.1</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; fi</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; fi</b></span></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><span style=3D"color: rgb(75, 165, 36);"><b>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; do_install_armm</b></span><b><span style=3D"c=
olor: rgb(75, 165, 36);">ultilib</span></b></div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div><b><span style=3D"color: rgb(75, 165, 36);">which triggered exception =
NameError: name 'base_path_relative' is not defined</span></b></div>
<p></p>
</blockquote>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div></div>
<div><br>
</div>
<div><br>
</div>
<div>The only thing I changed from the original files was that I added <spa=
n style=3D"color: rgb(0, 111, 201);">
<b><span style=3D"color: rgb(255, 0, 0);">&quot;DISTRO_FEATURES_append =3D =
&quot; virtualization&quot;</span></b></span>&quot; to the /Desktop/openemb=
edded/meta-virtualization/layers.conf.&nbsp;</div>
<div>Executing uname -a gives:</div>
<div>Linux lfpm1993-virtual-machine 4.13.0-39-generic #44~16.04.1-Ubuntu SM=
P Thu Apr 5 16:43:10 UTC 2018 x86_64 x86_64 x86_64&nbsp;</div>
<div><br>
</div>
<div><span style=3D"font-size: 12pt;">So, my question is how do I solve tho=
se warnings and errors?
</span><br>
</div>
<div><br>
</div>
<div>Thanks for helping me,</div>
<div>Luis Martins</div>
<div><br>
</div>
<br>
<p></p>
</div>
</body>
</html>

--_000_AM5PR0902MB2034393B2A72AD72872D272B87820AM5PR0902MB2034_--

--_005_AM5PR0902MB2034393B2A72AD72872D272B87820AM5PR0902MB2034_
Content-Type: image/png; name="Errors1.PNG"
Content-Description: Errors1.PNG
Content-Disposition: inline; filename="Errors1.PNG"; size=20030;
	creation-date="Mon, 30 Apr 2018 13:22:56 GMT";
	modification-date="Mon, 30 Apr 2018 13:22:56 GMT"
Content-ID: <9fdceaa4-54de-4b86-bd56-dde464d64fb9>
Content-Transfer-Encoding: base64

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
9/8DMM6b2i80YvAAAAAASUVORK5CYII=

--_005_AM5PR0902MB2034393B2A72AD72872D272B87820AM5PR0902MB2034_
Content-Type: image/png; name="Errors2.PNG"
Content-Description: Errors2.PNG
Content-Disposition: inline; filename="Errors2.PNG"; size=5529;
	creation-date="Mon, 30 Apr 2018 13:22:56 GMT";
	modification-date="Mon, 30 Apr 2018 13:22:56 GMT"
Content-ID: <01ae2961-d88c-4b0c-b656-f063a8de68cf>
Content-Transfer-Encoding: base64

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

--_005_AM5PR0902MB2034393B2A72AD72872D272B87820AM5PR0902MB2034_--
