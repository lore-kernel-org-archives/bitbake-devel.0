Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 25154 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 03 Jul 2018 11:02:14 UTC
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0072.outbound.protection.outlook.com [104.47.2.72])
	by mail.openembedded.org (Postfix) with ESMTP id 911A6786EF
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Jul 2018 11:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ZRX8S0d0gDc9ihYy2gDU62TfyEgIK9j1lGBOU2o0gLY=;
	b=DBiyl7HL5/jqROwL1ICpyooHfjauA6mTBnkuzq1K/Fwuys3eXUUcunuZOHrESLomGuAg883PB9adhbIrWokIkvg4fawHh29/hjRqPJ5q64B7Z34Ay2DWX+opg+u+l+TLNkx8Z7do+pv6I4cLgjmor2zsyxLDeJKYh1hagjfuHto=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon (83.173.245.202) by
	AM0PR03MB3827.eurprd03.prod.outlook.com (2603:10a6:208:6e::28) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.906.20; Mon, 2 Jul 2018 12:29:17 +0000
Message-ID: <1530534554.2962.7.camel@bbv.ch>
From: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 02 Jul 2018 14:29:14 +0200
In-Reply-To: <1520775403.10851.182.camel@linuxfoundation.org>
References: <355BE46A91031048906B695426A8D8E617342693@DEFTHW99EH4MSX.ww902.siemens.net>
	<1520775403.10851.182.camel@linuxfoundation.org>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: VI1PR0802CA0031.eurprd08.prod.outlook.com
	(2603:10a6:800:a9::17) To AM0PR03MB3827.eurprd03.prod.outlook.com
	(2603:10a6:208:6e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a44c449d-c6df-4492-0195-08d5e0176e0a
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	3:L6SvR6H1ZCvJdLjon4TycxC6lOd8XZsq/lFqtA4vtgx6gVgHs6j7U/01vSp96fLhoL8XQNmp+QIejui1vtELVTdwnGZIoE8oH9gTR/m2EOeF7JEk4msd5ICA5BzQykh/1ceTFAsGbWCh7HKH2D+/cRyV6RvObzuDSlHbneFf1MBxje7H0OyG4aCfRb3dlbKVf8N2dq2J1xOChaT/qh20WIi5MfOV+hCyECbtID8zJZ6KwvTFHIuNGirXniA5mSUo;
	25:0SB/wsN1nIroOONam+DrXObma5NIdUhoMfq1Cq5wZ81RF9mAYivO6bWqumT5fHJrBM2j5yLReyvKI7uv2RY148UpW6CPCBJ/mqzTZ63RT6suTk/V3yLNZTjeMtWoeMICwawCgW2CXM6mYg66lfLK1H/XeqX9Ho8vPxz7dCIPF3mdBS+o7s5Ssxp09M2qNaol9jlTeqcFmqw0IyDtpBvbKq7YMl9yL0985V5rH2/aXBlMiDzRTPMuuO4+zD9Ai+cM+K6w6V5snX5Z3DqeKgzYMN0YdIoX1avOhZSdHtL4d+LwmGMZ447g5WW5PA7znMEjjUipi9uZdeJpjNec3VGW/g==;
	31:MOGBh8kDCD+p68Sv/eU2D3irpC0YZNB+6cv3bbuTXgHHuf26zOzJH+sSQRRmq7va59V9XOr9xgNWWgAHOkMeVqwKg7GoKd8jUgc6NehcQQJl59eA+Ym6UFMRLNdGXm3GhUeCiz21SuqcjM4ZAOegP2wy7C6vkViY5VG5o5+7/SUQ2qz0x/wjivrZB+zz2MYSXvtinwFGhbHaQ1+LtNpmCBhMYuVOLrQs2i+7VngSAUE=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3827:
X-Microsoft-Antispam-PRVS: <AM0PR03MB38274746CF7335C2624874B48F430@AM0PR03MB3827.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(5213294742642);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);
	SRVR:AM0PR03MB3827; BCL:0; PCL:0; RULEID:; SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	4:rVs3X92ZCGBovSIvZHCMQDUFO58dxa7GZ6VWclPzRbDuA0xBMUwb1VkVZwDfI8mBEpXvfZirSgVVBqihq0DGHpgwNxm37p5+z6vtwX/I19lJLncDjuxohNvWTr6NytHE85esNYdo/OwCvGOXmAmNwCIPg2JyFKK1xrUoci0l7W1pxNo8lflq3Tc3YF+tvI0kHJOS67tNQBrr04UZR5Sww+99YIxvSwG/mEY38IfvIjo52X0shzMgynVNr/GZpVN7fYwZfLW65DEOSD0K11HuLdSRXMHcDFnqlGoDC/iBz/DeXF9R3BDt3sccyipD7Co8uO3uaHR4TFnCImuOETGT++JKZFhBWE347qWV9FJe/oM=
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(376002)(39840400004)(346002)(136003)(396003)(366004)(199004)(189003)(53754006)(36756003)(2361001)(6916009)(74482002)(50466002)(6666003)(230700001)(305945005)(6116002)(3846002)(2906002)(7736002)(229853002)(103116003)(81166006)(8936002)(50226002)(81156014)(68736007)(8676002)(5660300001)(76176011)(2616005)(446003)(66066001)(26005)(478600001)(2351001)(11346002)(53936002)(33896004)(956004)(97736004)(105586002)(186003)(23676004)(86362001)(52116002)(386003)(47776003)(25786009)(106356001)(6496006)(6486002)(5820100001)(486006)(6246003)(16526019)(14444005)(476003)(316002)(99106002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR03MB3827; H:talon; FPR:;
	SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzTUIzODI3OzIzOllRaEk2bk5PMWM2bG5NOFpDNTJXMGg3ZlZq?=
	=?utf-8?B?akN5Z1A5eDhEMTMxTWM2Rjc1S0xtUGtPbnlBZ21IaHJOa2ljNWp5OUJxcUN0?=
	=?utf-8?B?d0M1aHBnWWxqdXRnd1cyWE41UVZJaVM2OS9mZU5mdW5DSStNdFEzWVJtbnVZ?=
	=?utf-8?B?RFRJS1U0bys5aTAwaVRMeEpDWFk1NC9IbjdsVTgvNm1teGd2czArQzRoUTEv?=
	=?utf-8?B?NnV4YndiNU16akNnYkVadkx2V0xOaXRwWWkzQWZJSnVObUE1TVNYTGozUmZW?=
	=?utf-8?B?N0NBM0NaNXFIb3RjOWMwUkg4N2FvcjBHVG1rT3JPRlRJYlRmVmlHaUFKRUt0?=
	=?utf-8?B?UkRkOXVDd2lwbDZUNmh5K0JaN00rMEtHRzNHWmlQdWRzRWZuYlhDUjZsQThu?=
	=?utf-8?B?c3pLWUt1b2NvYjMyazJzcjJyYWNvQmh3emFkbFh0ZFZyOTNvd0taZ2lYYS9X?=
	=?utf-8?B?aEFkTlpScGt4T3M5TFlYVjVoTzhxU2htMk4wT2dVZzI3Y3lLcEY4Z3ZRVERX?=
	=?utf-8?B?czVCTmpRNTBLM3ZqWEczQXBsanFzaXVFRjVyQVMwNkhTN0ZQR0k2MFYxbDdG?=
	=?utf-8?B?UEhIQURKcTlkU0tFL3l5WXJFS2pxa3Jwd2hpbzhGT3lnWFBUZ3poYnZTT0Vs?=
	=?utf-8?B?V0pFY1czTEtCS1pDUDl5R2lNS3hzVCtib0hlbS9UZnZvdytpTnJZY3A4Qk1S?=
	=?utf-8?B?N1hyY1JQZU05aWxPNHhPS3d2U2ptaWhmWExZTG1MQjNESldBZlJwOWZqcDFh?=
	=?utf-8?B?a2pXNVpvNWdTNHFUcFhEM2F3Y01UZjhhWVVkODVvRU1OenY0alJad2hnalVJ?=
	=?utf-8?B?cTRkdTNtZkxTcmdQTk4vUXJBZWdITWRLRG9EbnZUZVhRc3Q2UjQrdmJhY0Fl?=
	=?utf-8?B?M3JkMzhkTHBjZ3ZxbkpzbzBPcFJXSFQ3SFU4YVJZOVlHU1RsakFGZFdBcWJY?=
	=?utf-8?B?bEZyT1dNY0F0OU9qL3BsbjRENXhpcFlreDFDRDBpVWZ4eSttYjZINCtoRjBx?=
	=?utf-8?B?MDF0MDZJcldPZC9TeWkveWdWcEFHbk9Hb3NDenM3WW5zVnY2RlA4MmFpZjBU?=
	=?utf-8?B?S090Q3llc2pmblZnaHBaTFBzUzlNVzNHWTZhVTBhM1ZsamJqN2w3NEd2K25l?=
	=?utf-8?B?TTArdnlyU1NxY1hBU3lwUlFiakxhcG1ybnZXQW9KKzk0enNsdWVJQTNSUDd2?=
	=?utf-8?B?K3FrTnk1cFdyS1V3UmhXNnU2bTI3ek9lWlJycnZWVWxhNHVydXpkelBjaytK?=
	=?utf-8?B?bkNkaTNoalgvRjlyWnY3ZjREREFuQzFKSURqcE80Nm5UQ2RHK3RxdDhBWjgy?=
	=?utf-8?B?SXlYUW53Uk4rVE93amtWcFBvOXpkNFhHamFMYXBYeCsrZ0I3d3BVQis2V1o2?=
	=?utf-8?B?WnkzeGxNMk1CVGM0VDJGMCtPSHlibURkU1RoakE4Z1VNVFBGMzBYeVpKM2NU?=
	=?utf-8?B?Sjg0eWR1cnNaZGVxYmZLcnozbGs5SUdQOVB0dVp6UU13ckRNeDBJczhEd1dw?=
	=?utf-8?B?YVM1T2VPQlJvZ1BXWFFlVk9RRmJJWFRzTWF3TjJYbWJkTGl0bUk4Umc2QW8y?=
	=?utf-8?B?dFBEcExqaHNHR3NmWUdZdDZMNHhuSjJQczA4V3B3aGFOdVo2cXJRUDUrRzFR?=
	=?utf-8?B?MjNIS2lzSnVBbWtwVVdxY3h4aVBQWUxwb0ZNdnZ4V1YrdUxiQXRFTTB0YUIx?=
	=?utf-8?B?Vmw3bnFIR0xJMS9IMlpCRTErbVJaQW14d1FBSmNhRXBQMWw5NmZ5VFFYcTNz?=
	=?utf-8?B?S1k5bVBWQURYYVIwbndDa2MxZWFVOHJnZ0IzTlJqY1dIaXpNclFVN0Z4enc1?=
	=?utf-8?Q?/5Gfk+nEG1w1l?=
X-Microsoft-Antispam-Message-Info: zvBYTREryDVEJfYCDtZtvgwACQU6120bSmNuju7NQBpsEdBThxr9ci2yQ/KNGnjfzvTEzBLOQp6L4ZiRw1hxUxy3LJmpa9NU2oaw0oJ6kTYWRewSLOGuqLrBrMQiugXCsnwZt5ldyf4oUcTs3q+LbRwDxuw5BkU1xE6wM4+DDw6oaH3GncImgRbEX5hGXU9icHQQT6obEoZbBbcpYvdJE+Pt4mwu/T3JOLejyDq68nOR8XitU/fKQJx5lb2Iyp7tY/7holHJSuG35+p4vGlGNcDK1Grgieb+CuAQW3XZyZSIsRXs9lEPReJ11W4oaEOP1cmU+6iG4e++lWc20YxPbAIRELQ9yyMY/9nQlO8vjZ8=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	6:wWuJIha+3iQM0emRdV5X3PL4MrkKAdxCyii3RU9f5HEN9il9LaXoWFIlq3wwkFqh+Eo2pV1fdaeDpW/nHFyhrv3nfLLUEqKyXyxSQVR0uN4j4k/msWL3a0gXmQR+dzZjq4KWdGbwHifROKoHhasEKc9t8SH7l4X8sjeRx91rf3D0pQbwdh3keiEEfKuU+I2rmsRlVFRlU7BOyfRms5v5FYJapeoJOoa/Nyc0yg4MGVaCOVw5DSq5AnMmqtSGCnV+Tsgjc/q/xny5esO6sBC8bvExYbwDtIRF6VOmzPEooNBLSJ9IGfvVZFrV3osIrqc/ldxNCRcMHlMbgEeVQjc0tiH+PHJg4STSn4Km0PL8PYs6t2WjF4MMtkp6FXcv3wmgXGPhU4KBFFQgkdyfs+tNpvNX4T0OVzPJyzQpxjO05DQEn+thLMN/fm257YbQ02rqNXjt/Oofq9CHaH/FvN0+zw==;
	5:ol+oW4D6eKVttTTY2zUpVb/vjBL9hH/GSjjnVHuGYlXw2LcmQLuFcLuRX6SOU+psLEoIdufmzVR++cB37oIdIzw+BhVqI1TiRIDxn+SA4nAVpWLqkPTHDDivGhvuH5lSZLIP86L40GFRV82IGjQ9lFVemVlDb1DgKDCFcTN5ea4=;
	24:AA4XWATA4ZBh2d+bejxn8LxOgTyMlucV0M99mvfJagSOAXwTjPf9NQ/ldNEzLgp3jW5+eG4pLjZ8CoBOt91IzvqsrH/odXXliT4ORtIzMVA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	7:gsOoDWVFIub+WZWK7+9JQU7IO4QLMzAblnH1ph12aCbV+oT1QfdJ4FyMp9k3FFBFgWU6csIV014zPALvcSEpchPNqOoXGIpsd/hHR48MDbAG9nDFUqyHf8Vj4j7Iem+dDVHriG5I9paj1weFfdzFQye0xr9Tnw2VlDL5i6SavCdVEplG5NU69tvVMthYaWXPR2GfRUntjlOuGO8Pn9nyofE+ud8teOSeAqjZiOJ8YuQldtLo9YRfmEMP3C9QmsrG
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 12:29:17.6249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a44c449d-c6df-4492-0195-08d5e0176e0a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3827
Subject: Re: Issue with bitbake fetch/unpack when using MIRRORS rewrite
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
X-List-Received-Date: Tue, 03 Jul 2018 11:02:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2018-03-11 at 06:36 -0700, richard.purdiea wrote:
> On Fri, 2018-03-09 at 09:40 +0000, Bach, Pascal wrote:
> > Hello Everyone
> > 
> > I finally got to pin down an issue that I occasionally observed in
> > the past:
> > 
> > When using the git fetcher with shallow tarballs
> > (BB_GIT_SHALLOW,BB_GIT_SHALLOW_DEPTH) experience the following
> > issues
> > during the do_unpack task:
> > 
> > ERROR: pseudo-native-1.9.0+gitAUTOINC+d7c31a25e4-r0 do_unpack:
> > Fetcher failure: [...]
> > tar (child): /home/projects/ccp3-
> > labs/oe/build/../../../downloads2/gitshallow_git.yoctoproject.org.p
> > se
> > udo_d7c31a2-1_master.tar.gz: Cannot open: No such file or directory
> > tar (child): Error is not recoverable: exiting now
> > tar: Child returned status 2
> > tar: Error is not recoverable: exiting now
> > 
> > The issue is that the do_unpack is trying to find the following
> > file
> > in the downloads directory:
> > downloads2/gitshallow_git.yoctoproject.org.pseudo_d7c31a2-
> > 1_master.tar.gz
> > 
> > However this file doesn't exist, instead the following file was
> > created by the fetch task:
> > downloads2/gitshallow_git.yoctoproject.org.git.pseudo_d7c31a2-
> > 1_master.tar.gz
> > 
> > After some digging I suspect that the following rewrite rule is
> > causing the issue:
> > MIRRORS +=
> > "git://git.yoctoproject.org/.*???????????????????????????????git://
> > gi
> > t.yoctoproject.org/git/PATH;protocol=https \n"
> > 
> > The line exists because we don't have access to
> > git.yoctoproject.org
> > via the git protocol. So we use the above rule to make access work
> > via HTTPS.
> > However due to the way the Yocto git server is structured the
> > rewrite
> > causes the URL path to change from / to /git which causes the
> > additional .git in the
> > resulting tarball, which then makes the unpack task look for the
> > wrong file.
> > 
> > I think the proper behavior would be to always name the tarball
> > after
> > the original SRC_URI not the rewritten one.
> > 
> > BTW: I was able to reproduce the issue with the shallow git
> > tarballs
> > but I think it also applies to normal git tarballs and possibly
> > other
> > fetchers.
> > 
> > The issue still exists with bitbake 1.37.0 on Poky master.
> 
> I do think there are likely problems in this area.
> 
> This gets tricky as one mirror tarball could in theory match against
> multiple different parent urls. I'm therefore torn on whether it
> should
> use the "parent" naming for the tarball, or create a chain of
> symlinks
> back to the high level name.?
> 
> Its something I'd have to sit and look at a bit further and
> understand
> what the code is doing. I know when Chris added the shallow code, he
> did add multiple mirror tarball support so it could be related to
> that
> too...
> 
> Just thinking out loud, you could have a "full" mirror tarball as
> well
> as a shallow one too so it does get quite complex. Which corner cases
> we care about is a tricky one too.
> 
> Did you have a fix to propose?
> 
> With the fetcher, I do ask when we make changes, we do add unit tests
> so that we can protect use cases going forward.
> 
> Cheers,
> 
> Richard

Hi all,
I got the task to fix this issue.
Can you explain where do you see the other problems and tricky
situations you mentioned, maybe with an example?

Regards
Urs


