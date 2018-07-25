Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0057.outbound.protection.outlook.com [104.47.2.57])
	by mail.openembedded.org (Postfix) with ESMTP id E6D0B753F2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 08:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=aVTyywQ9srO/Bu2A0FjzQDbxOSvLWNQlI2Hz507Kmq8=;
	b=MJAgmZ331Fxub+9/tcVAmJWMd9coDuag1YhoPMKubVLCYnDeOLH+i/J85fSk0Iw/LzaHuK2iWcYFe+hgus7/gr1NQG93I+DaUo5Wi5DGK0dM1m3nbKT2EMiLThSyxnpRWMAM8v0CMSYD7o3jfzUc6fR69GJCg4IQsDGK7PGYHIw=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon (83.173.245.202) by
	AM0PR03MB3827.eurprd03.prod.outlook.com (2603:10a6:208:6e::28) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.973.21; Wed, 25 Jul 2018 08:57:37 +0000
Message-ID: <1532509053.6506.9.camel@bbv.ch>
From: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 25 Jul 2018 10:57:33 +0200
In-Reply-To: <3bace14d7cbf7d350b146849d6f9eefc00fe9733.camel@linuxfoundation.org>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
	<3bace14d7cbf7d350b146849d6f9eefc00fe9733.camel@linuxfoundation.org>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: VI1PR0801CA0085.eurprd08.prod.outlook.com
	(2603:10a6:800:7d::29) To AM0PR03MB3827.eurprd03.prod.outlook.com
	(2603:10a6:208:6e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43288ac6-dbaf-48ac-57b4-08d5f20cabce
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	3:UCVm95ZNB4RQS6PjDFQPdHdHVVdWFsczztWwxd8Nb3rcxfwgTnsy5IQxcvQ3pxFoC1yVumFM0vt1khoWO4hGY2ro3GCEnipdTrZbYIJyRpeGF9Y+uRipJi1XbAjXqcasbLdIqGa2L6ZWEzdQuib4hSqlSIDbeknWNfU/Auvo0U492/BgQtmfTezV4ai247s9QG6Iy5K/Z9Y5tZ0EpmX3FyZrBp1n76/zsmulEIUysz1wBTZ4GaxiW6U+zeo6YyN4;
	25:6+eeZ9q8kHldFhAVWRiCKFtpv/kGVq+78SA8QXwqH/daX7w+nkrvgfZP+Tr03yNLvsARuDMtvRoEIfISWIQPNkNT5LgJRhQ9Nyba4ThVIAAqqoSiL0XxC/7y7K/aEKHckEhh/W9oJo7+38l982hMdndZChcj6cXs4deprxwveelNei/moDF0AkF0c2I2SrdHw9cxLvJms3/BaaNfIoJj3gNM8+ch3kUEv9AAK578jc+pmt3HuX+lHZmkEtWVwdO18hR5sPrIRBNR0wLIh3pp3ACFPRCjXsSuxIsjx0LF4XurXMyVl6+LUJnZz1fcg2C0E7ZFNjGC0nYFT3AM29k6sA==;
	31:3xEzDD4tVQo/lPgd6jJRCyQdb98HJ/2VBwcK0GQci6ZqA2tzsFpSWuzuIboMf3Des+F5zcX/pUsUAnLp9oExTPOtcQspQhsakBWiY9NFpBPYytMMUdt4priDBOwpeMsiVMM3gFcll5KOJ24yBcG5JaAogScvcL1q6BSGf0FrOwABf9G+f0V/qrOllVG3eVZZrMAvn7eIgsbFabJ5RepXEQGt7ENaPWuDlZdJhXVZDe8=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3827:
X-Microsoft-Antispam-PRVS: <AM0PR03MB3827007089029BB36F79E1138F540@AM0PR03MB3827.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM0PR03MB3827; BCL:0; PCL:0; RULEID:; SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	4:MLKJs+AuOU/jHkizA38R42QIzXWEEWIYpDDsbUdaZU6T1mbqzNUFAJn4EO61DLPTvDCVR/2jqxUHNxzxAe+qy0rMvCwYWu+sZ5sl+19ngNhxF6KR6D+29IIY/EmOZwrgZD5ZNUHHYSXgp6WvREYA1qKkcwOVd04XYNB5Gg3sqL7B8e8guMNH1XVWgejIIX0094lbRqLqVANuO1f3eIqei6H4QmpKpk4QlaoZsQuaNIBAPYFSWT8LTNvzQ5Qu0jy5S6qs6FCmwijl2MDsHiGzL/AntT0JQbanda77Gg8Gb1SJzNXWgkMWSF84DLb+QQ6d
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(39840400004)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(14444005)(305945005)(3846002)(386003)(5820100001)(7736002)(52116002)(23676004)(66066001)(33896004)(76176011)(6496006)(2906002)(8676002)(5660300001)(8936002)(446003)(11346002)(476003)(81166006)(68736007)(6116002)(81156014)(36756003)(486006)(86362001)(25786009)(478600001)(956004)(229853002)(16526019)(47776003)(2616005)(186003)(316002)(50226002)(6486002)(97736004)(4326008)(2870700001)(345774005)(53936002)(105586002)(26005)(74482002)(6666003)(6246003)(103116003)(50466002)(106356001)(99106002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR03MB3827; H:talon; FPR:;
	SPF:None; LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzTUIzODI3OzIzOjc1UVlQOWV6dHQ1aERiNElXdmRSbWs5WG13?=
	=?utf-8?B?cWJHeHdhQUZ5ck1aMTdCTFhUVEFGMDdFejlTNno2MnBCUll5MnRWczk2eEMx?=
	=?utf-8?B?V0szRTA0SmRFcmV3TWFhQWt0TWoyZUtnRUJTWlFla21aaG1mbXRENm94dEJq?=
	=?utf-8?B?Qit4OWlOOVRYdVQ4enZtb2FIc0lFZGgvZVd3YlptSmJuOW9sbEV6WG1WRzBi?=
	=?utf-8?B?eUZYZk9uNG96K0dwL1hqOUZIQmJENU1KcEQzV3dsMUEycnFCREdFejVXdmt5?=
	=?utf-8?B?ZGhxRmJOT1NoZ2VUVnN6U2VUbHV3L05Tck9aRC96eUlmb1ZRUmt1RjBER015?=
	=?utf-8?B?RFJtS0xFeUJmd0xYN0tacDVXN09GSG4xV0dMQjNEMnpKbzBNRUI3NjhLREJw?=
	=?utf-8?B?WlEzYjM5UnhpTk1rSmFrWFlCNThNZ2wweVNKR2dsdE4zaUJrQi9GU01ZMmVO?=
	=?utf-8?B?SElrNE5CQ1VaeTkvL1NkaXBySyt3cmFDNDFFUW9tdHlHTUJPclVDSjhoY1I0?=
	=?utf-8?B?YzhaY3NHNWVlbk02SzZGdG8zN0tMTEVWM01qT1ZJYjM4Y1dwdm8rRXlmTStP?=
	=?utf-8?B?QUhIYll3WEcwR3pqQjB6ZWJaTm9zdjA2cjMxdlRaOG1CNXhCL1Y3SXdzT0FE?=
	=?utf-8?B?VFR0K0pjM0FTb0w2OUtTS2piRmdsN2ZoMWl6RkRKWm1YcWo2WmhaVERWTEQ0?=
	=?utf-8?B?TjI4eXZwQ0pLbWxsdjU0Vk1uK3pyd0owTTlaTVdVa00vRTU0VUlxcHhvUmxG?=
	=?utf-8?B?OUZrc2hNM0tpU2JLbEhQWHNmeldZbXlDV2JoanVZMGZrOUw1aUlEd0dhVHIw?=
	=?utf-8?B?TWQvZDgvUjFyU2w5ZWkwZ0h4cCs0eXJzRkZCMVljS0V3UmJvOGY4V0dWeFBv?=
	=?utf-8?B?ZS9RSm5qV0MrZUtLOWNFTUwvWDFnVEVOMkRWa0RIMVhmdXNhdmZpNEZDZGRH?=
	=?utf-8?B?STlSNFA3VFRJbmtKQ0RsSGRpbnA4RzdqdEVhMzhSbC9hcmplUDM5WVZqNHFw?=
	=?utf-8?B?Mk1TcHdDZktHbzFyK21DUDBjNmNFUDg2Vkp1WXliR2hJcldjUVRBTjYrZ1c1?=
	=?utf-8?B?RDdJSVJIVlQycXdhaXRoOFJaZmpheTF2Y1VobFRXcmRyS3JEckpwYjMxSkdx?=
	=?utf-8?B?RzZpNFdFTkQxSlIrRnV6NG9IYlE4aEJXL29tS0J6Sms1b0FPL3ZZVTlPY3FI?=
	=?utf-8?B?em9LOU53ZG9ZTFVyTHBERzJSekUyT0g4UXlQWThXNitlUDBMb3FRZnMwU3lp?=
	=?utf-8?B?M2wrR2NLVStRcHZ3b21FeEJ3UHBleGhPcDJGSTNSUkI4RUpkRHV3eVBKd2NW?=
	=?utf-8?B?QnNPd3ZsaENidzlwMFUrY2hEaDQ0aUhHMVJacXFqaldBZDFXNDJjY0pxc3VM?=
	=?utf-8?B?ZEJaZVV0TWpocVB1d05TeDdxOUNoeFpWK3oyNHE4VG1VL0NYdmt4cGp5Qm9w?=
	=?utf-8?B?ckhQanFlS3E1M1I2cjNuM1EyUVUyZTBnTXNKQXJ0TU9ldE9Sa1FZUnZKWkov?=
	=?utf-8?B?T1NrSzhBMXhQWkpqTmp2Z3FuYllwcFhsdmx2bGdjUFkramYwcS9WWVVRcmV4?=
	=?utf-8?B?S2hLemdnekthaCs4ZFZjTUlPeUcycDJpLzNxaTBPYXRmcTdoQnRjVDQyNVh4?=
	=?utf-8?B?NUVlVzFDdXRCUnVSVThDajQ3bTI5OURLWVZ2VC9vS1JWTm5kdE5KOEtzWC9P?=
	=?utf-8?B?U1l3TDdBZWlZUnUyU3MrR28rUXlpT1lVZWtOUmFtTHNLZlRNNmtPalExRXA2?=
	=?utf-8?Q?s1PNnJHsJMznBDYUfBZOp57fD3X5xMR4wrsn4=3D?=
X-Microsoft-Antispam-Message-Info: KkO1akWyLYnyhvmv2cNN/io+kaDBlzWW7U+5conCaL5JnQzT/W8TwKxjVH9nG/ZZnojhPS5p+vCYZcTz9XxckIL+uULsTiaVhOHGF2MaCEMAhUsO8peawQpIsWaCh7RQeCGBmqdHYFFUGrvowlCHQ870knLczqqCkjdGCWBuub1XN47KLQc391W8l6urzjgzEUFG7uHP96Ye5gkKUneJtPLZZqw6MsfFmIdiyYJlCLeQkpZ6rDxYhcj6LRgmfXRb1J7Gp3+c8D26lTyNcbEKMQnDrHDd4rqZA/W6QRacXgB8huxSsoOkFCWHHBTO1TvLdrAtg2d3lWS1uvBTDbpg76ch0OifS6H2XuE5yfrjvfk=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	6:JAui5MDHfwMv/2IWGWZ5mFvx4gsYxZAabblkNnhYpSta8LGYjrdjtMs2W5mYmCiKos15SvFM+IAJ5Fz0xPC2nIdHKTOeS1CmuOjSfXmxPZT4edFBQxjoc1e7X+k3hO87oKhpHPZo4dJrLuPe4FZ1TzeMeG4fUTGFOEO5/3/fJDx9rEsTchUt9dLbQSVBw0xt91xIopYV8zXkp+6WbuPxcaDo2XvAgX7SkjmPxQuR26aLdguRSUqdl4n3znDympV3MF+U6QgGFl9P4tMTMr/CBOkSqGDdCxFlHBFn12EVbdbNIe5QFzXbhyG+r133z7xCpnT9+R8vKEXgKEkBpQIbC1Nee+LfE/ZbKiYE3dD/KLoIHaYYf4bK2D/BmPF6sTOIr4yLNl0aHCgmNktNGePyL4HOdbV25x2Peq0GwXqtiPo5krdTDlFyZ0pR6zU3R67tXAzAmZA1GqsnKBQ6H+DbKg==;
	5:NiiUiEDJ8dkQZdEreFSgC8Uo8qnI9mC27rrlhJEIoq5GXIGT1KYIp8UNvdWezCpmE4yFOLmKUn4NGugUoLvIgUSq87psHUWjIaknPXOH3devcUqBSSOVuOzbv//SmeI7DmN/VXKEhasal5jdAEX/pTxj1bLDBM1LcLLH8KUgxSo=;
	7:mj1PwGeCtR1pieWH7d9VBSiY6EuDCplj9LIdUI0WES+jFXtDPTN0Rw52Lai7iCiRUkz+9BHJn7spWyNzqQC0SrT3yB1nxFvlygVlBrJIIXH373VTEfsdT6HvmAVYyXfcPaGIH4UZF+yNb4zqpYRF1MtbaUWgzMghVKd+dz0tnY7UrBjiHgClFmiX8rZ8CDQvX3MCdL3dSRt724gpKAQh8SjFikXYop3pktGXc0Iekh7dc8UUbylipBXQfTylwGjk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 08:57:37.5936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43288ac6-dbaf-48ac-57b4-08d5f20cabce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3827
Subject: Re: [PATCH 0/9] Always use the url specified in the recipe as a base for the git shallow tarball naming
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
X-List-Received-Date: Wed, 25 Jul 2018 08:57:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Thank you for your feedback.

On Mon, 2018-07-23 at 23:00 +0100, Richard Purdie wrote:
> On Mon, 2018-07-23 at 17:42 +0200, Urs Fässler wrote:
> > The existing behavior was to use the url where the repository was
> > cloned from.
> > It happened that the tarball was not found when a mirror rewrite
> > rule
> > was active.
> > 
> > We now use the url specified in the recipe to name the shallow
> > tarball. It fixes that the tarball is not found under certain
> > conditions. In addition, the naming is independent of
> > network/server
> > failure and the mapping of the name is easier to understand.
> 
> I'm not sure why but throughout this patch series you've used
> function
> names and variables prefixed with "__". We don't do this with any of
> our other code so it seems out of keeping with the rest of the coding
> style.

I will fix that.
There are methods in the git fetcher (same file) that are prefixed with
one underscore. Is this the way to go or do you prefer no prefixing
underscores at all?

> With regard to the function "__has_up_to_date_clonedir" you added,
> its
> very unclear why some checks would go in that function and some
> checks
> would go in the other. The commit description helps understand it a
> bit
> more but that doesn't help the function naming or someone looking at
> the code in future.

I will fix that too.
The difficulty with this one is, that the use of "need_update" is most
certainly a misuse in this context. I can improve the patches to make
the misuse more clear, but it changes only a bit on the end result.

I am planning to resend only the patches that handle the cases when the
sources to unpack are not found (up to Patch 5/9 in this series) first.
The patches to solve the root of problem will follow separately.

> Finally, I'm still not convinced that passing around the original url
> and forcing the original url naming into any mirroring code is the
> right solution to the problem. I said that at the start and looking
> at
> this code change, I'm still not convinced this is right. Part of the
> reason I continue to believe that is you just added a N*N testing
> problem to the fetcher where the fetchers now behave differently
> depending on two urls passed in rather than just one :(.

Maybe it helps when I describe our use case and problem.

Our Yocto build machines have no access over the git protocol to the
servers. We use mirror rewrite rules to use git over https to access
the servers. Some server provide the git over http repository under a
different URL as when accessed over the git protocol. Since the URL
where we cloned the repository from is used to name the tarball, we end
up with different names of the tarballs depending of the availability
of some servers.

To be able to build our Image years later we archive the generated
tarballs. One way to store them is to use Amazon S3 which does not
natively support symlinks. To be able to access the tarballs from S3
over http, we use a mirror rewrite rule.

At the moment we have different scenarios where it fails, all of them a
bit difficult to reproduce. The common root of the problems is, that
the tarballs are not found because they are searched with the wrong
name.

I support your point that the same things should be solved with the
same mechanism. But in our case, the tarballs are not the same thing as
the local git clones. From our view as Bitbake user, the local git
clones are Bitbake internals whereas the tarballs are artifacts we get
out of Bitbake and use with third-party systems.

As a Bitbake user, I expect that the name of the tarball only depends
on the URL I specify in the recipe. I certainly do not expect that the
name is different depending on the availability of some servers since
this is a transport layer issue.

I think both solutions (symlinking tarballs and using recipe URL for
naming) solve the problem equally. We prefer the recipe URL solution
for better compatibility with third party systems.

But then I see that the symlink solution is the one that nicely fits
into Bitbake. I have to check if this is a feasible way to go for us. 

Cheers
Urs


