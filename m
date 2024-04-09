Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FFCCD1299
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 18:04:53 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.144610.1712685891853743240
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Apr 2024 11:04:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=K23Wlesg;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4829237d63=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 439Afjh3009288
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Apr 2024 11:04:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=7gD81qs2g7B6UMNvIhUxQTz7mJDseYe041Vw4UMOzPc=; b=
	K23WlesgwII/p26Gk4paP3tirlFL78m9UI8xZFKBiTbKsINDJpjKaABqXwdKULmZ
	mQDEdrud+33uz8SX0NteUgtOh4oR98+xJu0abVc2e7zsYENgAIcLW3qac++YjFS1
	NunpERvJiba0THvG4JGB+TvbLRqREwar2u/tshsxuu9fQNY5vKd3BHY3xJJb8PC7
	ddvatUjkq3HBnr6LHlNRCfQuC135bj6j/rBiNXeIhPfq9UrLLW5dIZWYu71C1Ieg
	19yOE2B6+NtDNDnxDBlvgPzqtgx/fE3COEqsgZLeH5JUyYquuc2Fwgrh7SqSlaCx
	EBL58KeaqAqplrIH2ym2SQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xb1p0auxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 09 Apr 2024 11:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYPBpKy+SjGIYrqJQfZitSGr9q1yoEk2A4aVl0Ok5gBi4B8yn1+yzuUamiO8oRjuD2ET5ZpSz4y/p8i4K4LajTTOvlXWduUlB28xSAiuEGvQwNGv7vF/cZ790RfOr07rBX960Vz5SgDwYNlL+da+Q/tqLAvo7XtfoBPQhiHzkoqQ0iW//UlkZxeZubH4kkEfdM6YEpqRumEqEVtIgA/zDNBEUwlhOK79lzf2H8sTlrwT975o/DjiHgQWmHiFkTCIOedh1FUeH2gCjYxbCTCw2qJLIHt9Ts/kYRkhk9br3t6FIJnu0HlMWoVFmgLD6yZvtDnTxCQkE1WORVSvJwdQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gD81qs2g7B6UMNvIhUxQTz7mJDseYe041Vw4UMOzPc=;
 b=JMiUkgJg6ITYvLEgUGf4JzO8KYuNifsWuGrcquPnNSzPL5qQ4Nvzp2TUalp/vBcqcw1ASA6kImssEQP+Y5qj79XX2M3NV9+xvH2jdiubRsNfrh3C4bX1u48glHrllBJuuaa/mjGPVZv8+3xFzhrQ2TdoH3ecagfeF5YA6VQ9nA0a/9/EPf+cDFTetvq6x52gCt1lg484tS++72pTzQRZYlmvCp7bch2VFaclUjK7AJ/3D2qsqQyqdl59VV20w0R0zaU2D8RRDq8udCVBZkQqo33jCfBzDwrghX/+fWtAY+9a7NrQy+lPYWuaH0Wd3KVYMSg56yvaRaVc+JQ3clxDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH8PR11MB6684.namprd11.prod.outlook.com (2603:10b6:510:1c7::6)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Tue, 9 Apr
 2024 18:04:42 +0000
Received: from PH8PR11MB6684.namprd11.prod.outlook.com
 ([fe80::9c5f:3795:2fa1:d5fe]) by PH8PR11MB6684.namprd11.prod.outlook.com
 ([fe80::9c5f:3795:2fa1:d5fe%3]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 18:04:42 +0000
From: "Woolley, Rob" <Rob.Woolley@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] wget: Make wget --passive-ftp option conditional on
 ftp/ftps
Thread-Topic: [PATCH] wget: Make wget --passive-ftp option conditional on
 ftp/ftps
Thread-Index: AQHaiqdSCK/WJPBd/keFR249ZSC6jrFgOu8a
Date: Tue, 9 Apr 2024 18:04:41 +0000
Message-ID: 
 <PH8PR11MB668449ECD0389A12E7F0CE95E1072@PH8PR11MB6684.namprd11.prod.outlook.com>
References: <20240409175651.876168-1-rob.woolley@windriver.com>
In-Reply-To: <20240409175651.876168-1-rob.woolley@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6684:EE_|DM3PR11MB8760:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0vcwohtyE3mwfvVeVds2ydEJ5Sp9yhWlVnZhd3+57b+COJK2CLLVcUdvDivsXsJ6HnHtYjuqacaEqDmPOnSzwCHMBowwBPRlxOLQlAdCwxEB8f5gkLh37p3u6VOYTywi/adZHntTK9R9sPbZLWS+nRl7TZh6O/+U5NIAYoOz4yfEHysn9LUMAfmqv1Oo2wcKVAkqTotEquixHR+HUigVkKMLoccN9FpaCB47eCVZIqijX3r36DuHhEv6o9gfSy8+v7rTMWiGJuGckviFuyOlfL7/UYcbxFpDR+463ZfMkZxfmDjHoa8pAsTmpa+C/2kJmHpGdh2etXP4P13wAFLqD2vZJPiEDq5L9EidfOOfj/Ua+BdH8rgcDlwWpcUcEFi0h2Mf8Vu2QJSrJzoql9veaFybvLEqSs9HD8cTmYhmSK8KXeRME0Bp/UiRY+8+O0tA/ia8iQWR6Lwcqwn1GC2OWCwbGaE2Xg8FUWg1wHAMXet4nhKqgmPjX1xUnhFnA5ipS+URzFjrpz76YjezrglHdT+PWOBnntAkzB85Qh68Vklkgb0GqGiMHSNn0r1flE9qY/YmnSkxBh9/AdYTQytkI6eR8QtLGO9UEBLe8lD8eiI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6684.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?W8AUUAa8jp51xkqjbfntE72YpRAao4FN9fgmbyMnFDX1HcZjT68sUcF6WY?=
 =?iso-8859-1?Q?GQ6XTm/94qlvqUHel4/CzPQK2BX+XEHK+RIUvGHPG5xJMV1A9QtY1UoQ1v?=
 =?iso-8859-1?Q?Qu415DdI9Tw9TBqRHXd4kNi8nxuzj+GqVMK34ASz2r+xsRrio0vuxGTG35?=
 =?iso-8859-1?Q?jgSer9rt2jTt7m1kKSV3NAdPrmimNaxrJ9PJ6Ia8IIbdG2cMjWaNOkMaKn?=
 =?iso-8859-1?Q?WuV+zz9v2ijFnN6jopDXSGdI+mSE+PscUxH5f4qXy6nq/T6QG3yc6Qrpx4?=
 =?iso-8859-1?Q?uqEXgv37aKNlRYESy9waeuy51nYGYXWQrqMQjixXZdydeNvc4dTSx4zU53?=
 =?iso-8859-1?Q?tlklIeMb0/RbVxT81su0D0wZgnZUqcw2fr3eIIxAyZ8prvDUzdSMRNjAd1?=
 =?iso-8859-1?Q?eSLo80ew57++/cz/YMroP+3qIxo2bbhk2aSqpkrJvQtMdTLv9NUaUsEn1+?=
 =?iso-8859-1?Q?YL9TIYLuxZTxfVppy9rKmZiIEpKrlATMRSNf/+oqYI68oRPs6qo5rj3mK0?=
 =?iso-8859-1?Q?2gOAUvT1oIVDXr6Uz/2Ls58k1dhuQkTEx4WOPgGifsPK13X9RCoIBUY6/I?=
 =?iso-8859-1?Q?/W8d8peC/k2lI1c7U8DHA1QflrHRhi36gHAIVvL4as1w3RjnojC5f/Pa7/?=
 =?iso-8859-1?Q?WCop/MI1hxwMkOq4XexMgM4laH72ZIemWS4BI1K3OkVktqvwYpvy0C5mgt?=
 =?iso-8859-1?Q?gQM+3vC1BYwFTG6JPdkNyiCsqXzpbUVALoW6vghNy6ImbXiqWcICPBr7Kp?=
 =?iso-8859-1?Q?4984iOe9my5N7PuY1lHTSTMaQjGj6FVI/rmnN7cOHT8WNr3yhKBY5cD970?=
 =?iso-8859-1?Q?GsTfe4RpBIddKLhWQ3XBuZ2XpyizOoqEXsmu1h/3T7F5teVF1pGEoDS7k8?=
 =?iso-8859-1?Q?1aESCdrWGs0HjsgxNMf7NYRInbWVuUAP9kBYAZCnv44deVN3iZrajgTUVn?=
 =?iso-8859-1?Q?NITTyV8zqwdoTBwxgvZuYFeaVjYnqz8MAGGb51sh2k03m573nwo5HnDz8l?=
 =?iso-8859-1?Q?XkxinzdjdrTTi6xOTCgjV2CU+qJ6pttDGpnrgzRiEgxHaUTBuGMFBSNXY2?=
 =?iso-8859-1?Q?ReWIL9gm2FMwgCLGpbwgR+WizRuoJTZk3g/j77GDYLXB7Ugypai0oPTiDt?=
 =?iso-8859-1?Q?nuX7Yb1P2OOOmBhgGgoYTlTqpk1KNSscujJ9Dhs06tk6vmr+od9m34Fcj6?=
 =?iso-8859-1?Q?lCfcfX0MPh0ovQEX72ypBi4veOJBD42kwv90G9OoJBXnubv3K1Lo7xO9OX?=
 =?iso-8859-1?Q?EJ9Id6BG2+i7P1QDJe6xAa9PIvuEjHaw1p5TSjAliSWWevpI0tU0aErPvL?=
 =?iso-8859-1?Q?o7qOq5QQUAl5C6h8q1GbR2OVzuz6iupfSdtJl1icD6DKl8uZLn2ruQkEMV?=
 =?iso-8859-1?Q?R5dBk6+RAfPhF2EJfxENXbtlmDrtKL9uDffyGK9vylXC/0unZcMt2wcB7C?=
 =?iso-8859-1?Q?ZHWcYLbpwFT6wWeY3MITWqKBUU3SPym1Kw78TLnGkLG4osHsw6YzRQMn7Q?=
 =?iso-8859-1?Q?J/6FW6AvmbDYRyTd92T+hERP5dBXi9lRxF/bZV0VkuoBiMr8F1KLF6UXqn?=
 =?iso-8859-1?Q?3LoDGnxpSu3axEG77kM5JDvRgDAI5qd8wK60BAZEAiBjmNA9dd/iXc6z68?=
 =?iso-8859-1?Q?60lxoU0g4lQKK/kmCUazJ/7Gq+APmZNHVzB3uCpoIgTi6728Rlhk89YnOU?=
 =?iso-8859-1?Q?RRNyoGZ2vCzrrM1XGMWns0e+f6HM9/9OHj856pnu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b553149-aa8b-4891-7eb2-08dc58bf87c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 18:04:41.9454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2HoDvBbbWRCtkQRPvSe/Ppt7YpK+yppo+9lpoLwgv9YFEzhH/7xn2nk7XESSz2s4r1yFmtQmzZI904IKPBonWNDnGNyUnw6g2J65T2ZQq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
X-Proofpoint-ORIG-GUID: rrdX-FZ2FjlSa1-EcFVyzubQQdoN2XjD
X-Proofpoint-GUID: rrdX-FZ2FjlSa1-EcFVyzubQQdoN2XjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=641 spamscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090119
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Apr 2024 18:04:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16066

Here is how I tested it.=A0 The libmad package uses an FTP source and --pas=
sive-ftp is shown in the call to wget.=A0 =A0The lua package uses an HTTP s=
ource and no option is used in the call to wget.=0A=
=0A=
$ strace -eexecve -f -s255 bitbake =A0-C fetch libmad 2>&1 > /dev/null =A0 =
| grep wget=0A=
[pid 666390] execve("/usr/bin/env", ["/usr/bin/env", "wget", "-t", "2", "-T=
", "30", "--passive-ftp", "-P", "<BUILDDIR>/downloads", "ftp://ftp.mars.org=
/pub/mpeg/libmad-0.15.1b.tar.gz", "--progress=3Ddot", "-v"], 0x55725cd864d0=
 /* 91 vars */) =3D 0=0A=
[pid 666390] execve("/ala-lpggp31/rwoolley/kas/layers/openembedded-core/scr=
ipts/wget", ["wget", "-t", "2", "-T", "30", "--passive-ftp", "-P", "<BUILDD=
IR>/downloads", "ftp://ftp.mars.org/pub/mpeg/libmad-0.15.1b.tar.gz", "--pro=
gress=3Ddot", "-v"], 0x7ffd73ce9820 /* 91 vars */) =3D -1 ENOENT (No such f=
ile or directory)=0A=
[pid 666390] execve("<BUILDDIR>/tmp-glibc/work/cortexa72-oe-linux/libmad/0.=
15.1b-r3/recipe-sysroot-native/usr/bin/aarch64-oe-linux/wget", ["wget", "-t=
", "2", "-T", "30", "--passive-ftp", "-P", "<BUILDDIR>/downloads", "ftp://f=
tp.mars.org/pub/mpeg/libmad-0.15.1b.tar.gz", "--progress=3Ddot", "-v"], 0x7=
ffd73ce9820 /* 91 vars */) =3D -1 ENOENT (No such file or directory)=0A=
[pid 666390] execve("<BUILDDIR>/tmp-glibc/work/cortexa72-oe-linux/libmad/0.=
15.1b-r3/recipe-sysroot/usr/bin/crossscripts/wget", ["wget", "-t", "2", "-T=
", "30", "--passive-ftp", "-P", "<BUILDDIR>/downloads", "ftp://ftp.mars.org=
/pub/mpeg/libmad-0.15.1b.tar.gz", "--progress=3Ddot", "-v"], 0x7ffd73ce9820=
 /* 91 vars */) =3D -1 ENOENT (No such file or directory)=0A=
[pid 666390] execve("<BUILDDIR>/tmp-glibc/work/cortexa72-oe-linux/libmad/0.=
15.1b-r3/recipe-sysroot-native/usr/sbin/wget", ["wget", "-t", "2", "-T", "3=
0", "--passive-ftp", "-P", "<BUILDDIR>/downloads", "ftp://ftp.mars.org/pub/=
mpeg/libmad-0.15.1b.tar.gz", "--progress=3Ddot", "-v"], 0x7ffd73ce9820 /* 9=
1 vars */) =3D -1 ENOENT (No such file or directory)=0A=
[pid 666390] execve("<BUILDDIR>/tmp-glibc/work/cortexa72-oe-linux/libmad/0.=
15.1b-r3/recipe-sysroot-native/usr/bin/wget", ["wget", "-t", "2", "-T", "30=
", "--passive-ftp", "-P", "<BUILDDIR>/downloads", "ftp://ftp.mars.org/pub/m=
peg/libmad-0.15.1b.tar.gz", "--progress=3Ddot", "-v"], 0x7ffd73ce9820 /* 91=
 vars */) =3D -1 ENOENT (No such file or directory)=0A=
[pid 666390] execve("<BUILDDIR>/tmp-glibc/work/cortexa72-oe-linux/libmad/0.=
15.1b-r3/recipe-sysroot-native/sbin/wget", ["wget", "-t", "2", "-T", "30", =
"--passive-ftp", "-P", "<BUILDDIR>/downloads", "ftp://ftp.mars.org/pub/mpeg=
/libmad-0.15.1b.tar.gz", "--progress=3Ddot", "-v"], 0x7ffd73ce9820 /* 91 va=
rs */) =3D -1 ENOENT (No such file or directory)=0A=
[pid 666390] execve("<BUILDDIR>/tmp-glibc/work/cortexa72-oe-linux/libmad/0.=
15.1b-r3/recipe-sysroot-native/bin/wget", ["wget", "-t", "2", "-T", "30", "=
--passive-ftp", "-P", "<BUILDDIR>/downloads", "ftp://ftp.mars.org/pub/mpeg/=
libmad-0.15.1b.tar.gz", "--progress=3Ddot", "-v"], 0x7ffd73ce9820 /* 91 var=
s */) =3D -1 ENOENT (No such file or directory)=0A=
[pid 666390] execve("/ala-lpggp31/rwoolley/kas/layers/openembedded-core/bit=
bake/bin/wget", ["wget", "-t", "2", "-T", "30", "--passive-ftp", "-P", "<BU=
ILDDIR>/downloads", "ftp://ftp.mars.org/pub/mpeg/libmad-0.15.1b.tar.gz", "-=
-progress=3Ddot", "-v"], 0x7ffd73ce9820 /* 91 vars */) =3D -1 ENOENT (No su=
ch file or directory)=0A=
[pid 666390] execve("<BUILDDIR>/tmp-glibc/hosttools/wget", ["wget", "-t", "=
2", "-T", "30", "--passive-ftp", "-P", "<BUILDDIR>/downloads", "ftp://ftp.m=
ars.org/pub/mpeg/libmad-0.15.1b.tar.gz", "--progress=3Ddot", "-v"], 0x7ffd7=
3ce9820 /* 91 vars */) =3D 0=0A=
=0A=
$ strace -eexecve -f -s255 bitbake =A0-C fetch lua 2>&1 > /dev/null =A0 | g=
rep wget=0A=
[pid 672596] execve("/usr/bin/env", ["/usr/bin/env", "wget", "-t", "2", "-T=
", "30", "-P", "/ala-lpggp31/rwoolley/kas/build/downloads", "http://www.lua=
.org/ftp/lua-5.4.4.tar.gz", "--progress=3Ddot", "-v"], 0x5567da0e86d0 /* 82=
 vars */) =3D 0=0A=
[pid 672596] execve("/ala-lpggp31/rwoolley/kas/layers/openembedded-core/scr=
ipts/wget", ["wget", "-t", "2", "-T", "30", "-P", "/ala-lpggp31/rwoolley/ka=
s/build/downloads", "http://www.lua.org/ftp/lua-5.4.4.tar.gz", "--progress=
=3Ddot", "-v"], 0x7fff467e4e78 /* 82 vars */) =3D -1 ENOENT (No such file o=
r directory)=0A=
[pid 672596] execve("/ala-lpggp31/rwoolley/kas/build/tmp-glibc/work/cortexa=
72-oe-linux/lua/5.4.4-r0/recipe-sysroot-native/usr/bin/aarch64-oe-linux/wge=
t", ["wget", "-t", "2", "-T", "30", "-P", "/ala-lpggp31/rwoolley/kas/build/=
downloads", "http://www.lua.org/ftp/lua-5.4.4.tar.gz", "--progress=3Ddot", =
"-v"], 0x7fff467e4e78 /* 82 vars */) =3D -1 ENOENT (No such file or directo=
ry)=0A=
[pid 672596] execve("/ala-lpggp31/rwoolley/kas/build/tmp-glibc/work/cortexa=
72-oe-linux/lua/5.4.4-r0/recipe-sysroot/usr/bin/crossscripts/wget", ["wget"=
, "-t", "2", "-T", "30", "-P", "/ala-lpggp31/rwoolley/kas/build/downloads",=
 "http://www.lua.org/ftp/lua-5.4.4.tar.gz", "--progress=3Ddot", "-v"], 0x7f=
ff467e4e78 /* 82 vars */) =3D -1 ENOENT (No such file or directory)=0A=
[pid 672596] execve("/ala-lpggp31/rwoolley/kas/build/tmp-glibc/work/cortexa=
72-oe-linux/lua/5.4.4-r0/recipe-sysroot-native/usr/sbin/wget", ["wget", "-t=
", "2", "-T", "30", "-P", "/ala-lpggp31/rwoolley/kas/build/downloads", "htt=
p://www.lua.org/ftp/lua-5.4.4.tar.gz", "--progress=3Ddot", "-v"], 0x7fff467=
e4e78 /* 82 vars */) =3D -1 ENOENT (No such file or directory)=0A=
[pid 672596] execve("/ala-lpggp31/rwoolley/kas/build/tmp-glibc/work/cortexa=
72-oe-linux/lua/5.4.4-r0/recipe-sysroot-native/usr/bin/wget", ["wget", "-t"=
, "2", "-T", "30", "-P", "/ala-lpggp31/rwoolley/kas/build/downloads", "http=
://www.lua.org/ftp/lua-5.4.4.tar.gz", "--progress=3Ddot", "-v"], 0x7fff467e=
4e78 /* 82 vars */) =3D -1 ENOENT (No such file or directory)=0A=
[pid 672596] execve("/ala-lpggp31/rwoolley/kas/build/tmp-glibc/work/cortexa=
72-oe-linux/lua/5.4.4-r0/recipe-sysroot-native/sbin/wget", ["wget", "-t", "=
2", "-T", "30", "-P", "/ala-lpggp31/rwoolley/kas/build/downloads", "http://=
www.lua.org/ftp/lua-5.4.4.tar.gz", "--progress=3Ddot", "-v"], 0x7fff467e4e7=
8 /* 82 vars */) =3D -1 ENOENT (No such file or directory)=0A=
[pid 672596] execve("/ala-lpggp31/rwoolley/kas/build/tmp-glibc/work/cortexa=
72-oe-linux/lua/5.4.4-r0/recipe-sysroot-native/bin/wget", ["wget", "-t", "2=
", "-T", "30", "-P", "/ala-lpggp31/rwoolley/kas/build/downloads", "http://w=
ww.lua.org/ftp/lua-5.4.4.tar.gz", "--progress=3Ddot", "-v"], 0x7fff467e4e78=
 /* 82 vars */) =3D -1 ENOENT (No such file or directory)=0A=
[pid 672596] execve("/ala-lpggp31/rwoolley/kas/layers/openembedded-core/bit=
bake/bin/wget", ["wget", "-t", "2", "-T", "30", "-P", "/ala-lpggp31/rwoolle=
y/kas/build/downloads", "http://www.lua.org/ftp/lua-5.4.4.tar.gz", "--progr=
ess=3Ddot", "-v"], 0x7fff467e4e78 /* 82 vars */) =3D -1 ENOENT (No such fil=
e or directory)=0A=
[pid 672596] execve("/ala-lpggp31/rwoolley/kas/build/tmp-glibc/hosttools/wg=
et", ["wget", "-t", "2", "-T", "30", "-P", "/ala-lpggp31/rwoolley/kas/build=
/downloads", "http://www.lua.org/ftp/lua-5.4.4.tar.gz", "--progress=3Ddot",=
 "-v"], 0x7fff467e4e78 /* 82 vars */) =3D 0=0A=

