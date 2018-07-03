Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 49686 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 03 Jul 2018 22:50:44 UTC
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
	(mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
	by mail.openembedded.org (Postfix) with ESMTP id 97548788E3
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Jul 2018 22:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fEOgcJjOeDazvghGGhr2h1AJo2NI0ZsUXhjavZ8W2qA=;
	b=ilJs3szt3Vc9cwGE7lLgZOAUTrdAIcpFvKB+xfCkAXLml7aCaVX2YBdb+stYxYSPpzUDts29nA1S8YkIBulqX87auvC/YEeUASR2TahmWLGw4UFtyqSv4tGEs5wUAs6NeS25kypPF8VATLLcyp0CSc7cSlKtjd2iz/WERULT1XI=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon (83.173.245.202) by
	AM6PR03MB3829.eurprd03.prod.outlook.com (2603:10a6:20b:24::16) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.930.18; Tue, 3 Jul 2018 13:59:18 +0000
Message-ID: <1530626355.2962.12.camel@bbv.ch>
From: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
Date: Tue, 03 Jul 2018 15:59:15 +0200
In-Reply-To: <1530534554.2962.7.camel@bbv.ch>
References: <355BE46A91031048906B695426A8D8E617342693@DEFTHW99EH4MSX.ww902.siemens.net>
	<1520775403.10851.182.camel@linuxfoundation.org>
	<1530534554.2962.7.camel@bbv.ch>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: VI1PR03CA0052.eurprd03.prod.outlook.com
	(2603:10a6:803:50::23) To AM6PR03MB3829.eurprd03.prod.outlook.com
	(2603:10a6:20b:24::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0b35669-1fbe-43f0-93e4-08d5e0ed2be3
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB3829; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3829;
	3:u6fMwgMeUaotQdHFx2LUtjtVAekSL2iqrlDaYCyVn5somuhjxcthR+Sy/v86AUR9e3J8s20cRvXCfWFgH62gyeNUmV8+O8yGWt10Aq9uIrJQu0xKQP/oKTuHv2vBkxX0PvM1I3XcgcoYq7fUFFBp5n8jZNO4rNE4zb/xPeTftg60ZxMyTS/3gOd2aXTZvbWrcCdB6yyVIfcyG9IaFMxPdD37lVsyxRMRReaXCEFmW71z/oYMJ34OsGVjQcB/jBtA;
	25:BLyUJznQRygoLiQii750BbYfujJfxd0GWz1rUMeCJRnJ3PkQUY/cgQuljtxy/fC1pyBwgfWag4UY7IItRPx8ndK0JDl7U08GjK7ZAS6xlOU3TKEsq7cE9sWMPVsDHy/e2dXJmeKnFZs1whvckCxI0nUri2dF9pRDidCavg1PBmhwwrKjZlufqe6ELFAq7DsQCXQ1Fr9J+a57a5Wfr65caRJIhQ6yAQoXJCz9JnKT33lHIqpdgyDkbC15pS/SxiY1NAi0RKy1MgGKHUOh/8P4hHwy/r2xc9Oazi3gBwqRG4pNybBpNxr3oE791wFvLfV2vMucdeVTE6Z56EKZ1f+cJA==;
	31:ZM3G3dj+mvD6utKs9FPX9KmU7dw761+cjjBtBtsE8MOvqbeF0HtN8uM15sT36n2jjQecpNZ1b3OSPmzmF6KuTABpjHvCjPSrFbJfJanfmckz3G2zqwK8bh/R0hTd06ppOkYiZo8ZoN/JA5J8cA7Pk7JOtDNlxGmHK+dTyBWaDg2XKFPrUflZxEcwDlAt5hSOtFqJSsF+SkSrUE52heAujIoOgLeZonssYFW8/Wet8hU=
X-MS-TrafficTypeDiagnostic: AM6PR03MB3829:|AM6PR03MB3829:
X-Microsoft-Antispam-PRVS: <AM6PR03MB3829BE01806DDEA5FC4E627C8F420@AM6PR03MB3829.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(5213294742642);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);
	SRVR:AM6PR03MB3829; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB3829; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3829;
	4:DJVpLfsTyos5TIcsV9WCvHnNrzxkZ6wWmkhuxV1WtbjFLeH7MsO80Ctj1CtJEC/JUVJ3s1ZYjPMWKXCblBwmP8xRtfPfM//jXSTBOlOq8reZI9LwUIrYkW7vP5VmfkvK4o1Z67jbyxpeQJKSu6eTNB9uG+gUqDKPFjLoAvWHsfVPpM/5DvjybbC/5DexPZUrOXYx0YMyRak90sslQY6vzTjiKdnYelzrvG801E25KDFOZlhLRi51/fW5oXfF6CwYRt1kpad8tZ1wP+hsr4v47/qeY2KkFlMKg4AKn1XCC4NGZIhqrJFVr1tOw25JPZrOrLvLgk6Q7xPnyBJ+9l0oABNuslunxbjz52eyZGz/QKM=
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(39840400004)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(53754006)(74482002)(47776003)(25786009)(4326008)(3846002)(6116002)(478600001)(6246003)(53936002)(229853002)(6666003)(66066001)(5820100001)(86362001)(14444005)(97736004)(8676002)(81156014)(81166006)(305945005)(7736002)(8936002)(2616005)(476003)(446003)(956004)(76176011)(486006)(11346002)(6496006)(23676004)(5660300001)(16526019)(186003)(386003)(52116002)(33896004)(26005)(50466002)(316002)(68736007)(106356001)(6486002)(50226002)(2906002)(2870700001)(36756003)(103116003)(105586002)(99106002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB3829; H:talon; FPR:;
	SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjAzTUIzODI5OzIzOnBldGFuSmRzSUpEQVQwVDFTQ1NXVXQ0SHkz?=
	=?utf-8?B?WlNEcUxaenczNGxjeDJlNTVFeGpxY1c2ZXJWTUc4ZEc5RU5NbWoraFBxQVFu?=
	=?utf-8?B?SE1scytvdzR4dG1saDRJWUpwWDh1bXZ1aGVlQjVDaTRmaGhpODhZanlwSHFD?=
	=?utf-8?B?aVhGM3dWaXVycW53YS94dHdYZmJkMldqcUtKZUdnRVV1TjVMNHcrWG9MbXBN?=
	=?utf-8?B?MURGYjZsR1JLMmdMUVdrU2Y2Z2J2bE91WXVEeXA4R3BGVThmd3VLTHhWQUcx?=
	=?utf-8?B?VHkvc3lOb1d0UVhIUm1QZW9BMFhpL2pmYkxJVGFYaTY2QXlNY0JXNEtuQ2VL?=
	=?utf-8?B?OW1DTlkwM1Q4ZmZlODFuRkFyTWlzaHprMjJjTXQ0Ukl4Y29aQ1JnZGdNenhU?=
	=?utf-8?B?cFozRjhQU2NjZkFpQUI1TUdhZWFwZGpjOEtmYlFhd0pmVklOd0lkUStlYldG?=
	=?utf-8?B?amVVdmVpRGwvZVc4WUd1Ti8zOXl5R2EzTTUrNVdING8zcWM2aUoxZWFjSHBs?=
	=?utf-8?B?OWU2YXI2SW5XWXRQUGdxUGZwV0FLOGIvcEJnYkxNNjdEVDhrUlFnd3l3bGRQ?=
	=?utf-8?B?L0ZPT0dQa3dVUGUzc2hNbTlUbThTVUQyeUJXUVQwMTlEWjNrN2NEL3Zwcy85?=
	=?utf-8?B?REg3dzJWajZuK1FIcDhGbEU5Nk1EdlB1R1N1RHZOMzRkY0ZYblM5YlAyWER5?=
	=?utf-8?B?NzhCaGY4cDZpMmNUdFE2aUJJVGlqRDBCOVNtTFcxZG5pUFdmV1VsMUVKUEpX?=
	=?utf-8?B?dnNhVzVYVWcxUDdJU2N5LzhENjFtaC84a200bmxxZy85TXB0VmE2S05td1Na?=
	=?utf-8?B?RUIraDU5dUd6MkxoR2Q2cC9vbXdXdXllV3JWTTEwNERoZ0RBSmJlOG1vYU5u?=
	=?utf-8?B?MkZzLytpRytDNG0xR09CZ08rcUNnOXVLOVJjRVE2S1FGNnlwdlRjTy9neFNW?=
	=?utf-8?B?MmVCY09yQnVOV001c0J3NXVZWDFIR0FYTHA5Z0MrNFpKdjlkQUU3cURNd1Fs?=
	=?utf-8?B?YU1OK0lOOFp0TXR5ZG13bDdDcHdwckZsdDRRR2lJK280QkxpWHZ5YUh1V0xm?=
	=?utf-8?B?RWo0S2tjOWY1S1k2Q2FpbExZdHQ2QkVRRHhOSnREcTNMRVFkZmNvam9OUnl6?=
	=?utf-8?B?emR2R3BPQ3Rpak4ySmhlUnlRMkd3MUMrdTlvYjl5TU9yRXU2cjR3M2cyODd4?=
	=?utf-8?B?QlVuc1lNSWNhajk2RlpoV1VVT29DQVg5SW94TDZpOUt5RVNqRnNzemVxdkc4?=
	=?utf-8?B?ZXRLSDEyVEZqT1UvMW1SeEkvcWZQYytYczFXY0czQnlXeWY3b3F0a3k5azAv?=
	=?utf-8?B?UUpFQnFjRzFuMTBKa0hoczJvcmZhdXFSWTFDTFVjN3FIZnNvQlcvenJFZU9i?=
	=?utf-8?B?a0pSZkJCcXNDWDk5bVNtQmU2TmU3WWo4NzlQNDhXcmlDb2t3NDFiVmN1dlBR?=
	=?utf-8?B?VEtTM1VzYUkwbVFGREdvY09xRURhOTVsc1pMNzJQNWxzTS96SDJrb3h3YWh2?=
	=?utf-8?B?Y2s5Ym96SEgxc3lqcGM5QmszTGZpYnlKNkhpT05MdHhzRTRNMEV5ZG5QQ2lD?=
	=?utf-8?B?amhMSDJyZW1WS3pUaHpGblFHKzZJczRYbmF3NmtNYXpGaDFCMVEyOTJJOEFm?=
	=?utf-8?B?dWpzZ1F6YVJsSllRNVJYTXh1eENtWERvalByYXFLRUdLZUZvOFl4WWx3UWJH?=
	=?utf-8?B?d2o0a2ZNMk1tQnRiZk1LcEpPMjVvbW8xWnFWQUpxeitYRFNIdkV4WXc4UDdN?=
	=?utf-8?Q?GJn3aNoPYzBdi3GnpAwOAg+yEvv2LZodG3sxI=3D?=
X-Microsoft-Antispam-Message-Info: Yi1tuPZb57OTP3N2vFbi+pNj21btE7+ktQOiBd2mmS7hLfAuwmiV0OjpItyoTeiNt/ySVNaKm0NeKZswWWKmlAV8QHLruaWK7W1HZnlUk2NuksKwMmhMR7W2mJmo0zmNDt62tgT+99zzkZHALWgoe+aMIbXHQHdPkK6isWQmtWAZ09SZkGwPV2BHHAVLAVBj9R3FDdkxO386DVdKlixWJcp+wwVLRejqBIC3wtVeUrByuU4LNdITNFbEk2x2etYifPXGDpgphz2xL8VjVFVk+glEFDa5ApZnL8jeictvjoh6Piz0LdsooOfApILUgP98TQt1jujy0dDmd1sxuNq7jx2JiEaLLyTkT+HQ+53/y/Y=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3829;
	6:T37HA0m5Z1shItNC8j1x3ulf3yeCgVUBwczXl2EKYQjQxYF3NCWTg7iEYTd9zdU5qKyoE74419cjGL2+ukMbgKWKs7ZWDEws4XqReJp+AZkvV45XRZVk3BIK7MkW1YErt77mWX6F8qzp3iYBI8lG5s1UF9FfnCOsehaSfq1Eetxf5C1Jm3hhLdKbYKeRrQZsOnGCfXC7DmGB+pyaQ7oc/1E8JP2FGGISVC+wgkE2V0vPE1IzHqCUSmC+a7ZhWJffF+VDNoIUtqh933pp2AaXwgWPLMm3H0EVyZMfpDNVoIfXuK1UmJ1OjMyKruiPkNLp1MG3Z7UjG/aDuX6c5cj/e5zj5OucRHtDd6HVBppPkFzXVhqzaESE1o147yhAecYPfG3GeEEJ3z9wiLRHuYbh3rRKVitZPb4GzDRI1i5gtHU+So0z7lxL+7o2fGnPbu9UGN1WqNz3lO+NANxX6O+zzQ==;
	5:aErRJHXHcZWmLSTceqjoq86gfveZ2AAi65TchIPtkbzTuxqfpnj/4Mh1z1pVF72o9Vijef1jThJsHAgyL/lM/Cyg68cTzSSPZudHO9DRqiHfu/aRgKppQLBT/cYuGc+B6tSMefV7VjwwbG6KNxp3tl4CJZnqoQrQycODMsDm0OA=;
	24:pDDKF68Wu1Hdxv47dsxE+b82s+XQHyPAtYqJNNRmn6Lv3EDc2k3YrViXaXrH+MBGevfQgvOckBELxUU00a7A2/7q5SzRMCSG/zVZhlGz3uU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3829;
	7:aS0ws0ty6maW0LFnYiS6RGnvPBVChoYeFUMqAXmcDmazjJHrQ2FYblW+U0MyLtIsAebzE1cJUZdyqEORRC8GITa0UfDu61GxvGmxO6gr/YL5TH6psRQ5GoBTsJFKDwUzsC7sSza2NMW4F6ns8rA6Bi+gm4uZb1pVhfkIHLh9zBHWDIso/+zXCFBdc91XVNWDn5TOWFhtcwdTgrRWcO94txORgGnMKZjCDRgsdl+WeeImkFfGfFdi4XMNQKANLNa9;
	23:8kU977ZBkbGF6XCTYOUYg/OxPeUVEA92Pwm52Z924MgGYCFf92E9EdhfGvsKpAThgpvNpD94Ud8+s2r3sIRGUgYjzEb0T/UnDF09nsTxZEfqCJ3JDolATOCa5u7uQlDHCcDWYfeFut2zSaqcAQKluQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 13:59:18.7136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b35669-1fbe-43f0-93e4-08d5e0ed2be3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3829
X-OriginatorOrg: bbv.ch
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
X-List-Received-Date: Tue, 03 Jul 2018 22:50:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2018-07-02 at 14:29 +0200, Urs Fässler wrote:
> On Sun, 2018-03-11 at 06:36 -0700, richard.purdiea wrote:
> > On Fri, 2018-03-09 at 09:40 +0000, Bach, Pascal wrote:
> > > Hello Everyone
> > > 
> > > I finally got to pin down an issue that I occasionally observed
> > > in
> > > the past:
> > > 
> > > When using the git fetcher with shallow tarballs
> > > (BB_GIT_SHALLOW,BB_GIT_SHALLOW_DEPTH) experience the following
> > > issues
> > > during the do_unpack task:
> > > 
> > > ERROR: pseudo-native-1.9.0+gitAUTOINC+d7c31a25e4-r0 do_unpack:
> > > Fetcher failure: [...]
> > > tar (child): /home/projects/ccp3-
> > > labs/oe/build/../../../downloads2/gitshallow_git.yoctoproject.org
> > > .p
> > > se
> > > udo_d7c31a2-1_master.tar.gz: Cannot open: No such file or
> > > directory
> > > tar (child): Error is not recoverable: exiting now
> > > tar: Child returned status 2
> > > tar: Error is not recoverable: exiting now
> > > 
> > > The issue is that the do_unpack is trying to find the following
> > > file
> > > in the downloads directory:
> > > downloads2/gitshallow_git.yoctoproject.org.pseudo_d7c31a2-
> > > 1_master.tar.gz
> > > 
> > > However this file doesn't exist, instead the following file was
> > > created by the fetch task:
> > > downloads2/gitshallow_git.yoctoproject.org.git.pseudo_d7c31a2-
> > > 1_master.tar.gz
> > > 
> > > After some digging I suspect that the following rewrite rule is
> > > causing the issue:
> > > MIRRORS +=
> > > "git://git.yoctoproject.org/.*???????????????????????????????git:
> > > //
> > > gi
> > > t.yoctoproject.org/git/PATH;protocol=https \n"
> > > 
> > > The line exists because we don't have access to
> > > git.yoctoproject.org
> > > via the git protocol. So we use the above rule to make access
> > > work
> > > via HTTPS.
> > > However due to the way the Yocto git server is structured the
> > > rewrite
> > > causes the URL path to change from / to /git which causes the
> > > additional .git in the
> > > resulting tarball, which then makes the unpack task look for the
> > > wrong file.
> > > 
> > > I think the proper behavior would be to always name the tarball
> > > after
> > > the original SRC_URI not the rewritten one.
> > > 
> > > BTW: I was able to reproduce the issue with the shallow git
> > > tarballs
> > > but I think it also applies to normal git tarballs and possibly
> > > other
> > > fetchers.
> > > 
> > > The issue still exists with bitbake 1.37.0 on Poky master.
> > 
> > I do think there are likely problems in this area.
> > 
> > This gets tricky as one mirror tarball could in theory match
> > against
> > multiple different parent urls. I'm therefore torn on whether it
> > should
> > use the "parent" naming for the tarball, or create a chain of
> > symlinks
> > back to the high level name.?
> > 
> > Its something I'd have to sit and look at a bit further and
> > understand
> > what the code is doing. I know when Chris added the shallow code,
> > he
> > did add multiple mirror tarball support so it could be related to
> > that
> > too...
> > 
> > Just thinking out loud, you could have a "full" mirror tarball as
> > well
> > as a shallow one too so it does get quite complex. Which corner
> > cases
> > we care about is a tricky one too.
> > 
> > Did you have a fix to propose?
> > 
> > With the fetcher, I do ask when we make changes, we do add unit
> > tests
> > so that we can protect use cases going forward.
> > 
> > Cheers,
> > 
> > Richard
> 
> Hi all,
> I got the task to fix this issue.
> Can you explain where do you see the other problems and tricky
> situations you mentioned, maybe with an example?
> 
> Regards
> Urs

I investigated the problem and saw that the download/pack task uses the
mirrored url to create the local filename while the unpack task uses
the original url to create the local filename.

As I understand the code the link between the filename from
download/pack and the filename from unpack is missing. It seems to work
because they are usually the same.

I don't have the full picture to decide what solution is best. But from
my understanding, it should be ok to use the parent/original url. It
could match against multiple urls, but they should contain the same
version of the data. In the git case, this is secured by the commit
hash in the filename of the tarball.
But I like to hear your opinion.


