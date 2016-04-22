Return-Path: <Joel.Esponde@Honeywell.com>
X-Greylist: delayed 3558 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 22 Apr 2016 11:09:52 UTC
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2on0113.outbound.protection.outlook.com [65.55.169.113])
	by mail.openembedded.org (Postfix) with ESMTP id 444377318A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Apr 2016 11:09:52 +0000 (UTC)
Received: from SN1PR0701CA0080.namprd07.prod.outlook.com (10.163.126.48) by
	DM3PR07MB2123.namprd07.prod.outlook.com (10.164.4.141) with Microsoft
	SMTP Server (TLS) id 15.1.466.19; Fri, 22 Apr 2016 09:38:45 +0000
Received: from BY2FFO11FD028.protection.gbl (2a01:111:f400:7c0c::196) by
	SN1PR0701CA0080.outlook.office365.com (2a01:111:e400:52fd::48) with
	Microsoft SMTP Server (TLS) id 15.1.466.19 via Frontend Transport;
	Fri, 22 Apr 2016 09:38:45 +0000
Authentication-Results: spf=neutral (sender IP is 199.61.26.155)
	smtp.mailfrom=Honeywell.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=none action=none
	header.from=Honeywell.com;
Received-SPF: Neutral (protection.outlook.com: 199.61.26.155 is neither
	permitted nor denied by domain of Honeywell.com)
Received: from DE08W1027.honeywell.com (199.61.26.155) by
	BY2FFO11FD028.mail.protection.outlook.com (10.1.15.217) with Microsoft
	SMTP Server (TLS) id 15.1.472.8 via Frontend Transport;
	Fri, 22 Apr 2016 09:38:44 +0000
Received: from de08ex5003.global.ds.honeywell.com (10.216.34.43) by
	DE08W1027.honeywell.com (10.221.248.38) with Microsoft SMTP Server id
	14.3.266.1; Fri, 22 Apr 2016 02:38:17 -0700
Received: from DE08W1305.global.ds.honeywell.com ([169.254.1.251]) by
	de08ex5003.global.ds.honeywell.com ([10.216.14.76]) with mapi id
	14.03.0266.001; Fri, 22 Apr 2016 05:38:19 -0400
From: "Esponde, Joel" <Joel.Esponde@Honeywell.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Fetcher issue: Error communicating with
	gnome-keyring-daemon
Thread-Index: AdGceHU9FcWlpVhrTX+l8V+kRxiwFg==
Date: Fri, 22 Apr 2016 09:38:19 +0000
Message-ID: <F6CD090A69E64C4289DC608E1C5D2024253E0CBB@DE08W1305.global.ds.honeywell.com>
Accept-Language: fr-FR, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [158.138.38.18]
MIME-Version: 1.0
X-CFilter-Loop: Forwarded
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.61.26.155; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10019020)(6009001)(2980300002)(199003)(76104003)(189002)(19625215002)(84326002)(19300405004)(2501003)(450100001)(5004730100002)(5003600100002)(16796002)(230783001)(54356999)(512934002)(50986999)(107886002)(92566002)(189998001)(110136002)(6806005)(55846006)(105586002)(77096005)(2930100002)(15975445007)(2900100001)(2920100001)(102836003)(5008740100001)(551544002)(3846002)(16236675004)(6116002)(66066001)(1096002)(87936001)(2906002)(229853001)(586003)(2351001)(11100500001)(86362001)(33656002)(19580395003)(106466001)(81166005)(790700001)(1220700001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM3PR07MB2123;
	H:DE08W1027.honeywell.com; FPR:; SPF:Neutral; MLV:sfv; A:1; MX:1;
	LANG:en; 
X-Microsoft-Exchange-Diagnostics: 1; BY2FFO11FD028;
	1:w65Lic7IC2kHeQFLzocDeOMu5LNG7W081zs8+xc2tnmjP2+58vUkJEZdUKbkXOZggK23qiyjys0HpQsbSgyyZWsb7+FOzw3kOlqd/XbFx2X7Hyei8olvwSm6gbTKT9Rz9wLPFgKYmwqo+n3wTp2NkiN36VsWHziq/TwTxtXoa3iGYEyRuLW2nJsdnGHokKvQl0Q2xsa5WnabP/ccTwGNEPHA7R9O2Wb8Bz0u0LZNjy5MVF7tJoc6yVvy0JFk8hBrRy82xH1y+y9aHuxZoi9p2rdJ6wfEWrwnfpX6OZYZHwjfYXMNSDwSpeZ2OuZLEXt4hwtpkQb4m960uRmJJlAhuy2IglHB2QlZIMhuFEsQNzBqYsqC9J6wj/r4UDNNWSRTjnTg89Zi/n3+9ijxymnXDhE/0uSyJhrpVy1CzwnkGOdnNTniKFkryQciZp7pmmcuXKEHm5jMziNqw89vMMAgz+kREqGaqZD0wrLId6XznvOtgE3mZ5YYnM2UJsmV8Lbi
X-MS-Office365-Filtering-Correlation-Id: 86a631e4-62b3-4a34-42f0-08d36a91e5c8
X-Microsoft-Exchange-Diagnostics: 1; DM3PR07MB2123;
	2:5Q/UhWo9CF8XLeo/Kmrusp9V74aOt5Vl9Dk3PLxgU4vpig9svVmGc8k+U999cyojAwEltCgqXSsQP2QB2LFNAM0mim0ESHEI5KlFfjDcq0HZZtvn2xXdNnYQGwhITBr1LRpwzGqAWn1GPqHDhJwvNyj37eO2ErWfEeStPt/Mh4ubBV01ydU08gsYw53b4qKT;
	3:yA07V0DZ2HQInUWLf0aDMbcgUoF0e564O2tl1iWC9JQmndYP8ZrQgwl8u2v6AH8G6sNcEbbE0ZX8Wy8EavNtgHkPp23u0xIYv8K50GP/oyHW2ZOL0YgCJBtM5JFEQO8jMVXlR465qmvB0Tp5g2uplAB0BHr9Yc/PE+uhdx5YSapoeSdPIxcq1NTpdeuDaztJIEXz/PvM5Q+p+jCQwoGFJcqBb9q49SkgzKviPvDPFlQ=;
	25:eAiqwxbPM84oZiecIC9kB3eega2ssl1qDmDNrZzCDRvhFZkBexyTjSrZ4Cm8juszCB7qrJY8TAnwweG3QL8q022mjHA3btYaFg/gyt1GD5Q+NILwRyRQFAVLxAwNI7IGtEHyrneHAR4lV8WxUheteBgzzeVGy3pQYpHDwnB9gyvF6gG6Rl/KJx0lfW/QPvRe4nBlv+LUR40TLxPTMLxt/+HOCggKYCzfpFAZwSmoFTeB4QvJ3wdRhgAatdljpUP1SUQJH7+MsQPRMlAKBtX4zdHH9MvH4YUiojdCc35CR2nLrfTgQ9XCl04w2BZA7Sc+YA8l9wm2ZoDMt01trhQP9Q==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2123;
X-Microsoft-Exchange-Diagnostics: 1; DM3PR07MB2123;
	20:eCJ1TY5n9Ys19+h3sPiO4t32f2E8P0FANp4xr9XUl5urc6OBNHlbKC5QU8DaFXaSgqwB01y7VmbeVTPh0p0mba0wgZ/KGilz9gvVeJxL5G4A7BPD94PbhoIeSKu5m4dTnok/py96ALhVevqEIyfm0R5IIyhTStX8usPLRYglxaNhyzNe0eqHs6slgmC6TOwRk6gFBt57Is7v05GCPI85hDeaXgb+LllgJF0QJBGF/3u+Cz7bwyV53eSWjPWSs9BuIbrHtU7P40ZWzVcpwU40K3liR57VCOrnOofphAMh6QnZCnPl5t9So9WE+hPMOuMxqRnuly4V4WA9qawGzmGE6XP/R7fEGaaTo97t4E4Zlvyj5BL04fg/2PmujVYHeFe/bG7eAv8OyDJJqoQduC2MSrlUY4yjQv2VioyC4Igou3jrLq1T2WrM6RWoFM/KrTd4RUEnHuJi7H1+RFYM1EdjFU6Ph+Ia0KcY9M+sT3tGftn9LOiyyL4i19VqPvVl9shd
X-Microsoft-Antispam-PRVS: <DM3PR07MB21238D332DD41FDAAC948154966F0@DM3PR07MB2123.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(9101521026)(601004)(2401047)(13015025)(13017025)(5005006)(8121501046)(13018025)(13024025)(13023025)(3002001)(10201501046)(6055026);
	SRVR:DM3PR07MB2123; BCL:0; PCL:0; RULEID:; SRVR:DM3PR07MB2123; 
X-Microsoft-Exchange-Diagnostics: 1; DM3PR07MB2123;
	4:5cFszy34qd4f+NA+ZSQt2e23jhXKVXSpvLrtGLKUoZke0IV8QukSNtA9zgIlA558Txyf18OtqX8BhhIHB3cAATeJwl4fzoBjbi7VIVwsBGMJ0FLpHNILTyWlZRMdkIWJBF8ETXcpUCz9oQ1gSHz7b6fNsXanmx8JGIM1/TTStg8JTOiYOT2K6OS2pCWbUQPN2ljl5DEZkbZvXBA0gaWKZAwvdTOHfsDYQNx9NxEDFJYB/K+/03SGl4XaQ+K16CLHe6l+Pz9OjjBELNft/ZJSjgJSA57J0Ga4956rkuDIzPeYjvDQ26bd4ULZFVt63KpYoeAT7vAkyCYEtES+LJiqRyGdLXY2Il3iGdySsERzVXwKMGT2zpBNi8bS2GX37BOCszoZQwtc1FUTTeUkuaJDkeC+S7W7Nd2g9PO6AY6VhfdIqwddOZH4DEcry9Pk5jg+aG0XT8Bzu5kpqm355RmwQ2ZzGbCStjlx020at874IMxq86fJWJ6yd+LuYNzkKcob
X-Forefront-PRVS: 0920602B08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DM3PR07MB2123;
	23:ZnPA3edbF279gePWDN2nDmlJW1QxN66ZUTJcqZhrF?=
	=?us-ascii?Q?ipmJmny1+KL9opz1MBBUveDC15PVgY15Ubyzif4sDXfSn5JyjjbFr8l9ZUZC?=
	=?us-ascii?Q?cYhG0QFVoOQLfl0EtZiiBy8iUiwbZ1o7HLYa7ammv+LBqe08lZieirQtXNL4?=
	=?us-ascii?Q?1oBWkvU61ZLK/44FiAO6Jxf3Z5wq4wHlu/Rv9LiOhr/KEOmSDvIfUzqDqCRO?=
	=?us-ascii?Q?Mz0Bje80ASXiEKdXF3aaOQh9YG2QVaACD9kmZokeQf6g86pJ7bGR1BpXwbGi?=
	=?us-ascii?Q?Zy2euE2QrjAye4yZD2GzgJD1hfIsyVljV/3162k0zH6BxV6hiWY7ehHvHZpd?=
	=?us-ascii?Q?woFnmCYjsShQhzYv7CIRP+6t4TJTGjvq7BUh5vbvDpC/Uvw2ZLAbqfs+Pjhd?=
	=?us-ascii?Q?u+YJwsZSey0kPPNWfcYgDcRs5jcKi2HHQoEPXOkY3wrE4QT9pKNms4xuGJf5?=
	=?us-ascii?Q?yR1jGVcd7ppyOaD0G6ndFmdxcMS/hcpmsONj48+mQQ+hN6LM0FiU71lG6Ljs?=
	=?us-ascii?Q?FgNmAmvJnR7Hron2ZLf3G5yFnbx7SkR4cy87/yBynCuSgg0hkiBfuElCOEqP?=
	=?us-ascii?Q?/FAfE0+w4QwgN14P3xTHalF6uEG1RCehWAisM3qhuIbdR6QE3rDNiZ4dXWwA?=
	=?us-ascii?Q?VcpN0kNkWSDiPhLbZin95hsyz1ivvua0Rr04QrFHTymbpNhWD7UhMOXjK/WN?=
	=?us-ascii?Q?KUeck7ARs8K4GmC4p/MqDUTG+fE4jTDHUI8uzs/gI/iisorvVEaF9pDjp/Cb?=
	=?us-ascii?Q?Mx2WZuqI3fSd3uYxv7nm04ovx5tQnLzxgNUvPqzLQ/XvQuojvTtG+oOi8AiD?=
	=?us-ascii?Q?4gHv5CQQAZxnHBE8+yAhId2tSZi1DGZCsY4uk15FSLPXNoVFtIuv07Lh+6Ts?=
	=?us-ascii?Q?gBUG0TaajpkDwKuXJu5zLvhqpRXxl21dQxJKjenNjr5ntaanAXWY2WQD6bH5?=
	=?us-ascii?Q?ZmKXajg6aB1/zHfZgiixvUS2rFyY39SZJHOJeuZsM2rz6VF2w/ZUw8vHDJ2z?=
	=?us-ascii?Q?t+SHDnxCHKy055vWCbLSj1TFm6CzgpTSLH0QDHg/DuugniRBDDPCODNTdVP0?=
	=?us-ascii?Q?KeZupiMFSkIWJOhAPgEUZM4xSU6dJCAG8StBNejAATk7z/xKlrodzt5Nu29/?=
	=?us-ascii?Q?47AKXFbDlEHd+BVuvLPVp8GcwHCZs2fyzq5+EmIjQ/nIHYNp8cQ7HtUvJVCP?=
	=?us-ascii?Q?SKBVt850g5elwfxmQedDO9OCrnxUI+X/pK2YQzs+IyKaB8nMzWp9pqGRK/LT?=
	=?us-ascii?Q?nlP/XYXGSSdssYeNeVwrjYml0dTRaCmz/8yuxZJYeK0Y66nk2UiRC+oVG2ga?=
	=?us-ascii?B?UT09?=
X-Microsoft-Exchange-Diagnostics: 1; DM3PR07MB2123;
	5:Qi/eSoJAJa+GbOXyznB0zsXb7JYA6Y0/oUx4Fd7wOBZRbkQz9rQN5DZE4vrOpRH2baZoa5cqT6EtqY/MyFQMUcDOjuBLPafeyfx9tE4b1RdTBqOa4AtgoYD55QkMKPMD+1G68WBThmAGNnC6lZqrF8sSzLUlozfCq5e0awfSKQCwlIf/dRwzYVMoP1An4kEK;
	24:IMPxMxYcSprFPBwOLjjETFJ4l044AJR+Yf+ztsu/ZrmE2gS6DCdt+I1tj1kK6P+hkBF8tDd3DYauTfyHM+zx+fe8Wxc7yTRL7P04N0XUFoU=;
	7:LlUfYMic+5ZsVLVt7Bhkd7QkQ9FtOgKFKKnXjZccUMWnhvt85342W+deZNiRFxgKbYDeqJHgsXnz9wT5ZfwWobmIHujySsfSDa4wCSvQ9hhB84rcWYtsGQMwZyt0pL9R0dEuJ0hV052EkqcTiwRfOFUACe0OMYfo63zZnFPLANXMdLBliMuU4dI9frSrEx8FWT1it2R73Hbufde/UEFUF5zmP0Ce3j0PC0kZpVOd+wc=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Honeywell.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2016 09:38:44.3068 (UTC)
X-MS-Exchange-CrossTenant-Id: 96ece526-9c7d-48b0-8daf-8b93c90a5d18
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=96ece526-9c7d-48b0-8daf-8b93c90a5d18;
	Ip=[199.61.26.155]; Helo=[DE08W1027.honeywell.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2123
Subject: Fetcher issue: Error communicating with gnome-keyring-daemon
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
X-List-Received-Date: Fri, 22 Apr 2016 11:09:54 -0000
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_F6CD090A69E64C4289DC608E1C5D2024253E0CBBDE08W1305global_"

--_000_F6CD090A69E64C4289DC608E1C5D2024253E0CBBDE08W1305global_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

When bitbake tries to fetch code from a git repository that needs authentic=
ation whose credentials are stored in Gnome Keyring, it fails and produces =
this error:

    ** (process:53010): CRITICAL **: Error communicating with gnome-keyring=
-daemon
    fatal: could not read Username for 'https://git.someserver.com': No suc=
h device or address


git-credential-gnomekeyring is the helper used by git to store credentials =
in Gnome Keyring.
git-credential-gnomekeyring uses D-Bus to communicate with Gnome Keyring wh=
en X or Gnome environment is not accessible (for example, through SSH).
Therefore, *.bashrc* is modified like this during *git-credential-gnomekeyr=
ing* installation:

    # git-credential-gnome-keyring:
    # If you are connected to your workstation via SSH, you'll need to set =
up D-Bus,
    # or else you'll get Error communicating with gnome-keyring-daemon.
    # The solution is to add the following to your .bashrc or .zshrc file:
    if [[ -z $DBUS_SESSION_BUS_ADDRESS ]]; then
        if [[ -f ~/.dbus/session-bus/$(dbus-uuidgen --get)-0 ]]; then
            source ~/.dbus/session-bus/$(dbus-uuidgen --get)-0
            export DBUS_SESSION_BUS_ADDRESS
        fi
    fi

So one way to allow bitbake's fetcher access Gnome Keyring is to avoid DBUS=
_SESSION_BUS_ADDRESS variable being removed from bitbake's fetcher environm=
ent.

This can be achieved in those two steps:


-          First, fetcher's code needs to stop filtering DBUS_SESSION_BUS_A=
DDRESS, here is the fix:

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index b004dae..392e307 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -784,7 +784,8 @@ def runfetchcmd(cmd, d, quiet =3D False, cleanup =3D []=
):
                   'ALL_PROXY', 'all_proxy',
                   'GIT_PROXY_COMMAND',
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
-                  'SOCKS5_USER', 'SOCKS5_PASSWD']
+                  'SOCKS5_USER', 'SOCKS5_PASSWD',
+                  'DBUS_SESSION_BUS_ADDRESS']
     for var in exportvars:
         val =3D d.getVar(var, True)


-          Secondly, bitbake needs also to stop filtering DBUS_SESSION_BUS_=
ADDRESS thanks to its environment set like this:

$ export BB_ENV_EXTRAWHITE=3D"DBUS_SESSION_BUS_ADDRESS"

What do you think about this fix?

My main concern about this solution is that any user that would store his g=
it's credentials in Gnome Keyring would have to set BB_ENV_EXTRAWHITE befor=
e being able to use bitbake... It does not look like very handy...

Jo=EBl Esponde
Honeywell | Sensing and Productivity Solutions


--_000_F6CD090A69E64C4289DC608E1C5D2024253E0CBBDE08W1305global_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:#400000;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:420834140;
	mso-list-type:hybrid;
	mso-list-template-ids:1730204854 -1564840762 67895299 67895301 67895297 67=
895299 67895301 67895297 67895299 67895301;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"FR" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#400000">Hi,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#400000"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">When bi=
tbake tries to fetch code from a git repository that needs authentication w=
hose credentials are stored in Gnome Keyring, it fails and produces this er=
ror:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; ** (process:53010): CRITICAL **: Error communicating with gnome=
-keyring-daemon<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; fatal: could not read Username for &#8216;https://git.someserve=
r.com&#8216;: No such device or address<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">git-cre=
dential-gnomekeyring is the helper used by git to store credentials in Gnom=
e Keyring.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">git-cre=
dential-gnomekeyring uses D-Bus to communicate with Gnome Keyring when X or=
 Gnome environment is not accessible (for example, through SSH).<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">Therefo=
re, *.bashrc* is modified like this during *git-credential-gnomekeyring* in=
stallation:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; # git-credential-gnome-keyring:
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;# If you are connected to your workstation via SSH, you'll=
 need to set up D-Bus,
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;# or else you'll get Error communicating with gnome-keyrin=
g-daemon.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;# The solution is to add the following to your .bashrc or =
.zshrc file:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; if [[ -z $DBUS_SESSION_BUS_ADDRESS ]]; then<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;if [[ -f ~/.dbus/session-bus/$(dbus-uui=
dgen --get)-0 ]]; then<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;source ~/.dbus/=
session-bus/$(dbus-uuidgen --get)-0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;export DBUS_SES=
SION_BUS_ADDRESS<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;fi<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; fi<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">So one =
way to allow bitbake's fetcher access Gnome Keyring is to avoid DBUS_SESSIO=
N_BUS_ADDRESS variable being removed from bitbake's fetcher environment.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">This ca=
n be achieved in those two steps:
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo1"><![if !supportLists]><span lang=3D"EN-US" style=3D"color:#400000">=
<span style=3D"mso-list:Ignore">-<span style=3D"font:7.0pt &quot;Times New =
Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US" style=3D"color:#400000"=
>First, fetcher's code needs to stop filtering DBUS_SESSION_BUS_ADDRESS, he=
re is the fix:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">diff --=
git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">index b=
004dae..392e307 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">--- a/b=
itbake/lib/bb/fetch2/__init__.py<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&#43;&#=
43;&#43; b/bitbake/lib/bb/fetch2/__init__.py<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">@@ -784=
,7 &#43;784,8 @@ def runfetchcmd(cmd, d, quiet =3D False, cleanup =3D []):<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 'ALL_PROXY', 'all_proxy',<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 'GIT_PROXY_COMMAND',<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 'SSH_AUTH_SOCK', 'SSH_AGENT_PID',<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">-&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 'SOCKS5_USER', 'SOCKS5_PASSWD']<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&#43;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 'SOCKS5_USER', 'SOCKS5_PASSWD',<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&#43;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 'DBUS_SESSION_BUS_ADDRESS']<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;for var in exportvars:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D d.getVar(var, True)<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo1"><![if !supportLists]><span lang=3D"EN-US" style=3D"color:#400000">=
<span style=3D"mso-list:Ignore">-<span style=3D"font:7.0pt &quot;Times New =
Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US" style=3D"color:#400000"=
>Secondly, bitbake needs also to stop filtering DBUS_SESSION_BUS_ADDRESS th=
anks to its environment set like this:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">$ expor=
t BB_ENV_EXTRAWHITE=3D&quot;DBUS_SESSION_BUS_ADDRESS&quot;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">What do=
 you think about this fix?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">My main=
 concern about this solution is that any user that would store his git&#821=
7;s credentials in Gnome Keyring would have to set BB_ENV_EXTRAWHITE before=
 being able to use bitbake&#8230; It does not look
 like very handy&#8230;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif;color:#707070;mso-fareast-language:F=
R">Jo=EBl Esponde<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:9.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif;color:#707070;mso-fareast-language:FR=
">Honeywell
</span></b><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;=
Arial&quot;,sans-serif;color:#707070;mso-fareast-language:FR">| Sensing and=
 Productivity Solutions<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_F6CD090A69E64C4289DC608E1C5D2024253E0CBBDE08W1305global_--
