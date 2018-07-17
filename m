Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 19333 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 17 Jul 2018 18:12:29 UTC
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0063.outbound.protection.outlook.com [104.47.2.63])
	by mail.openembedded.org (Postfix) with ESMTP id EADD2789BD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jul 2018 18:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=IZ/mIzrmQXCujAgP9u4KHk6noorZnBmudINyDM6c34k=;
	b=R2xcL3At2A2GgLK9uYo2CzuULvE8dgv6CEL0D9HOy2XmUYPm9BsGGYWXeD8WNkKfkTbOuTVVqX7N9EgmTlK8Ddq2S8HLHX4S3CXJYxYC6uUgWY1klvsYvQCvGeJXs6k+Pf+vk1ZXeG9Tv/eGryuJdQXRpZT0Q7Dp5Qo5S+rZnM8=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon (85.4.236.58) by AM6PR03MB3832.eurprd03.prod.outlook.com
	(2603:10a6:20b:24::26) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17;
	Tue, 17 Jul 2018 13:39:32 +0000
Message-ID: <1531834769.2962.38.camel@bbv.ch>
From: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
Date: Tue, 17 Jul 2018 15:39:29 +0200
In-Reply-To: <27b7bf4b1cd46e051b3c9c9e109ecacf6f238336.camel@linuxfoundation.org>
References: <1531826153.2962.36.camel@bbv.ch>
	<27b7bf4b1cd46e051b3c9c9e109ecacf6f238336.camel@linuxfoundation.org>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-Originating-IP: [85.4.236.58]
X-ClientProxiedBy: VI1PR09CA0063.eurprd09.prod.outlook.com
	(2603:10a6:802:28::31) To AM6PR03MB3832.eurprd03.prod.outlook.com
	(2603:10a6:20b:24::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c55cb6ee-3f09-4bd8-393b-08d5ebeabab8
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB3832; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3832;
	3:IyGCUvcupxyrGkVAnPOQ1Nxg69lsyHuesskEmCaoD0UGkx2IQ++e8n+SvZyPHi7Uh6O5b1LPNED5N+Y3615Qk4XvcHUTdElDaPH1AWy7FJ6h9xyMXuUg/9OuwcXP/stklsg4L+oUtkr1Y+aDE02IvVPTv2iMX+u7+u8E2DWdBsJ83yI5MDefN/8+JHLrvogT0UwN89+QPBr8990SOLH9tvUibaMkzKRom3yv7ZukN2Xgl2XHfukoVyu85TUUApZW;
	25:Uw3LvrN40Gm2BZGcscDXWpLvbY+pT2QKfwuT10lqM/rM5ZGhfkwfzGFUFbg5cKRr0xflnIJXY+VHR/OQ+SINzHCGmh0RPzg59YmFg5xFopNPfXdx92YdtunUzlcete6bUCY3GRRp5fiBZ3NB/ZBUAEMARP3uTCrQ+ilY688IW8peKYTiRmyguP3jq7NRI3a/9OFE46+TRvElPy6JVxJ2gChpVBAizyFrxerxOgg0QZG4GG2xdwOid7KvdAiVcreTMbJgMKgdeOTRbWdXXNff+ayge0OPJKWdifi9sH3r4VdkyiqUonl9AVL3E7Pt+9MOXoNIZddANinQ8oeXWIiqzQ==;
	31:F3r+EUBg65RVs9Xq+XZqvdwoMhAPgY2fuxGHeHP5QTXz2XmvqOV+Q19ZFsmnM3GRhrfC79rLVeG6r4uMWHn0l2UtvPrfgvVzMRHWrDZpvhP9/8gl0ThmZIzLxOTS551up9FK7nOZPD9+NRmWew29b0Zg/Zhl18LoUI4t/mXvoU7D289OoE+u8tD++JC8MuxK5uIenGVKYkN5Y5qRId3KTReBOMECTQsuTNQ27Bzf5kI=
X-MS-TrafficTypeDiagnostic: AM6PR03MB3832:
X-Microsoft-Antispam-PRVS: <AM6PR03MB3832E53B5765A347FA5FE3048F5C0@AM6PR03MB3832.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);
	SRVR:AM6PR03MB3832; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB3832; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3832;
	4:wTL31sEvXIF9aWRvO4K1zVVuQnFgRGBJ5Ts2Juvuo0YeoBpWVaErlcZoc48GiKqfPGb+GnHrcKZGGDJGA0r2w70EMw9LpfUbaYHc46tnYNdZig8t4FJAalXKSxlIaoZkBtg1K/RvSru8Ff4Q8qJxC7E6D4HvbqodKeQWH1b19OO7Wcw0edL48zrbcfzg46om+40EevFUp3LGdzRkTMESB2yVCaXKZG5iTxP12tgKU6Ty1tVwb3nn8TguWRo4m3BNE1YLTNP3j3assZMZda6RrKSOQbz9Hwy6GH4VpeG0f03IbaFycP1cg/JLYvlKvVgU
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(39840400004)(376002)(346002)(396003)(136003)(366004)(189003)(199004)(305945005)(52116002)(23676004)(2616005)(6496006)(7736002)(446003)(6246003)(486006)(5820100001)(186003)(6666003)(8676002)(8936002)(4326008)(476003)(11346002)(25786009)(956004)(50466002)(76176011)(16526019)(2870700001)(105586002)(33896004)(386003)(2906002)(74482002)(53936002)(81156014)(106356001)(14444005)(50226002)(81166006)(26005)(66066001)(6116002)(47776003)(229853002)(6486002)(103116003)(3846002)(5660300001)(316002)(478600001)(86362001)(68736007)(97736004)(36756003)(99106002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB3832; H:talon; FPR:;
	SPF:None; LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjAzTUIzODMyOzIzOmFBYnhYV0NhQjFkOEVubzZ4MTZCRGtPNE5u?=
	=?utf-8?B?MVk4ZG1INkFkamV6N3RVWHhiczBCZTFnNnJTdGRnWmwzaFZsSWZKUExSeGZn?=
	=?utf-8?B?WnBwNWN5UXdwdHNseXZ3Mjk3NkVFZlVZL3pFWCt3SEpSZGN5NDJxOGNSbzlU?=
	=?utf-8?B?L2Z4QWcrQk9ER283Q2YwS0ZpYk9jWDVMajUrb0tabHhCbzM2MzFvNEpKQTh4?=
	=?utf-8?B?ZnZDY3U1ZmlJZ0V6ODgrd1d1eGx0VkJPWE1lWFhMWi9OaTRNZ29kS1FneE1M?=
	=?utf-8?B?cjI4VVU0Nk1NZ0E2YXpyRGtxV2h3VVl1M1VpamtrQ2pSWmNaVlVXMXpuRTZH?=
	=?utf-8?B?VHZPYWtPT1ZuU1NaM3lhVkFSZUM0azZlUEFBRUJMWVVHSm9zbWd1MlhtM2py?=
	=?utf-8?B?NVVzOFhMcm53RytrZkVaQ2pxOGk0WGQwSzZZVnBqYlBUc2c5Z0Y5ak5tZ3FT?=
	=?utf-8?B?dEd0SWhIUUtOMHl2UEdXakdjZW95K00rVkRsdGh4Mml0QnF5WnpWSDkzS2ZF?=
	=?utf-8?B?eDZ5WkJDS21wQlZteFJtcDhXZWZMeTJ4THdpeGJUWGo3aFVxK1R6ZGxCY3ps?=
	=?utf-8?B?WGhHUUpVUjVHR1ZLQjh0OWZQRzlIQlJic1F4dmwxbjdRUldxRDlkaE5xeVJH?=
	=?utf-8?B?UWQ5RENJQXR2UXMyUDBmR3YrV3VhMlVDbFJqOU5QVlJ2aEJibDdyazNxZVZs?=
	=?utf-8?B?K3NXcDJ4Z1NhdWErZ1lsZ2xHVlFuMnhBY0NBZ2hlOUhQMDU4L3FwQVNmVjhy?=
	=?utf-8?B?Z3JWbVgxcVJIUTJ2ZDVRTUdYUFpSSVBLRjE5TjFmUTFtYkNEM3hGRk5YeE9W?=
	=?utf-8?B?emw5T2loWVB1dTRLcU5POFdNL011K0g0V1ZZRjVjK2g2S2J3UnUzRSsvUGhS?=
	=?utf-8?B?WkZUYWhONHgrRG1wVTFuMWZkUHZNcW9yR21xVGRvcjVQL1FNRWRRTDF3cW5l?=
	=?utf-8?B?YzFpSFI4Z0ZPbWtsSWRqMVB3ZUFrVTFKUmNGTkwzci9ZV1hxQUNwUUdQQ1dB?=
	=?utf-8?B?Nm9nZ3pxUE9BWFQ3MTRNSU4xWmtDbk02c2lTM3EzcWtMazY5YzZrODJqbmxG?=
	=?utf-8?B?d1BpaUtrWkFmM1RLZFVoYjBPdDNDcklWR3Q0MklpZXhvZEF2WndRUUxjVWJy?=
	=?utf-8?B?MVAvdFBMNGw5YUxMM2VuNzJxVWNRRHNkL2hoZ0ErZFJKa3ZGb2FuZGRSZTNG?=
	=?utf-8?B?a080ODRoNlV5dDZCb2l6bUdRUm1OcmZvZkZ0ekdHTlhtT0VhV2VNR0YrTHVv?=
	=?utf-8?B?NDF1NVhlQXVxVWdkY1BpZ3gyN1Ribmc0U0lnSFZjY1FRSFptZnhqeUVCTlJF?=
	=?utf-8?B?Vmg2RUhJL3I5a3RqSkVVaGVpTzZpUVhOaGpvV0NwT3pIcU9RWnN4b0xjcVVY?=
	=?utf-8?B?aVZOdjFNd3dpS3N3bHBaRENoSWVLQnJKeWVUK0hZK01PbTQ2V3pudzJSdmlE?=
	=?utf-8?B?ZVluOEtUZ1NNNjczUUNycXExVTBkT1lGZkkrZUxvL3ZLWTYzcGR2QWJHc3dV?=
	=?utf-8?B?MFgrSmY1ZUZ0NGx5WWZNZmxxcWpkZU5BUVZmNE5ZeUtUa0hFVVRjbGZlYXlL?=
	=?utf-8?B?a2IySEJPZFFDY2I3ZS9FMnlTVU5wb1UrYjZQLzJwTXNPMTVZZHVkN3d5b3J2?=
	=?utf-8?B?WmpBaU0zeDBROU1JcGFMdEJkTjdRYnRkTndXS1ZHQ0x4TXFtVUFOT3AyZUYz?=
	=?utf-8?B?d2d6TlU4ZnRKMVJUeVdmUTM2Ti9ua2pDejlGUlpjc3hBRHhqQ2NjZ1U0dDNS?=
	=?utf-8?B?RllxZ0VqVDU2NU9Eejl3UT09?=
X-Microsoft-Antispam-Message-Info: T5DwchkZEdPn9NHP74C63K/CIat4sYB0b25yh17sU8ixdvm31jGy2ISogcSC8FxeMyo9CW4MOzllMiij0aGSG4ywqRtdnCOkMbjPHv09NXHM+7vpKt0/a738zAIOCfrJWD5n2G6O/sxsFeGPK+pEzmbZ+gnT40d3AOAuE4E9aS5zBgh3a0/uIlsogQqsc5Z0RWskl5/4u1qa1uGV6yDNdRzfmZXprGvxEDkHXVBhPlg6Ctmdfl/NNx7KGx0VK1AnwPQRKNA5LNfd6P1kYQrvqugJyQzQfvtEFW5djEbVFP/oHBEjLDlQdh9D0q+rnka0PK8IJ4KucnAKUrrG7KcUJ6aZbNv1xU+IJat7OEaetJY=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3832;
	6:pkCKg5ilEYgRUKcx4r+8ExGMnIOPJSR0ndejHhFsZ+j/JtqbGv6uy8rsMmmm8PA6bHv2YDG7+dnp6pQlDMeZvc1NfWGTgeCe8fA09Q7TeBBYifLkEblFGV6V6/+kLPEmpJ16D3RrKXYih4SMKcJiVX2gBasD/i6FsGcWsISeduwWg+EYT4A6Geq53W+YpXNiKq16SbjIHIdi23BKTQ5+TxBTcAxZ9qAsd6/gkybesM6uEzH8JLOVIdv1TL6m4unrsrE34iUNthSKbMpgnN23TzBoY6JUaZFDIGgkDOus41jHcDcNQiW0wAATzYJ7aYP7UAyWEHWDAUOjAuRWUaPTKZHqATEXHcNH2gPGWzE60Z+/vO8t/dxTIQwdBb/+2tVH/eXX0jx1IMfMVNO9hCfpFK2QqY/LhPZn4+tFKu3vRN/uHexPBwmZoT+GPDef5OwH7Z2V5wqjmWeWNvnFCh5P7w==;
	5:bwmKb4sKlnENeZ/COTobTUsE1ePmFlfYq9F2dw+w5+u3E+Wc5YO4GVGU2HQHE7ravq0Sow1DwnY7W/UK//hdcOIiV5/kzywfxgQb+L1Rg8g53Ej8xVdBgSLdPGsx6+DcIoE5HdEMBfBaaXlP7a0yJA8X8ar0MWOFFaeR41P1Ewc=;
	24:Xg8ptPSoBW9SePsmxEdQ6Rx3zeoG0GHS3nZXc7yUIAnWKafDEsDcWiztk3Wa06pIXOt6fgUJpwHzKJ+34829TzvIkcN1SdipDTMgphf5whc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3832;
	7:kZURLVp7MXWl/4v9+lR50wRW91wCUlH1ucVHLwfUsEAjEPkIUSlEEm2WmQtrcNDq1ryFsVBw5zqiIMKm/l/IINJSIfYXxjRKskp8/enbs1Nkfh2kIGo6khD03FqHR45ZhxoXDk3T/rw2CV91AMFtO7fot5X2K6PzYr4rL7BPzauyNSrNgiIur2ozK+jvljzCGaHaRyh9XYYW/njTMovOae+VmOv7NTriGfXHCje1G/TPQoeat13NHIQsD+HerUux
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 13:39:32.6610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c55cb6ee-3f09-4bd8-393b-08d5ebeabab8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3832
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
X-List-Received-Date: Tue, 17 Jul 2018 18:12:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2018-07-17 at 12:24 +0100, richard.purdie@linuxfoundation.org
wrote:
> Hi Urs,
> 
> On Tue, 2018-07-17 at 13:15 +0200, Urs Fässler wrote:
> > I investigated the issue that the unpack step fails when using
> > mirror
> > rewrite rules.
> > 
> > The root of the problem is, that the download step uses the
> > mirrored url to create the local filename while the unpack step
> > uses
> > the url from the recipe to create the local filename.
> > 
> > As I understand the code, the link between the filename from
> > download and the filename from unpack is missing. It seems to work
> > because they are usually the same.
> > 
> > I tried both solutions proposed by Richard: Using symlinks and the
> > recipe-url.
> > The symlink solution is nice since it follows the same methods as
> > for
> > git clones. Unfortunately, it is not practical for us. We like to
> > store
> > the tarballs on a SMB share or S3 storage. Both do not support
> > symlinks.
> > The recipe-url naming method is nice since the tarball is named
> > after
> > the url as it is written in the recipe. This is easy
> > understandable.
> > But unfortunately this method breaks the test
> > "FetcherNetworkTest.test_gitfetch_premirror", which tests the
> > following: when 2 different recipe-urls point to the same mirrored-
> > url, the repository is cloned only once.
> 
> Would you be able to provide a kind of worked example of the problem?
> I
> think I understand the problem but some example urls, the mirror
> format
> and the resulting different mirror tarball names would probably make
> it
> easier for me to comment on this.

You can reproduce the problem with a current (rocko) Yocto. Add the
following lines in local.conf:
  BB_GIT_SHALLOW = "1"
  BB_GENERATE_MIRROR_TARBALLS = "1"
  PREMIRRORS += "git://git.yoctoproject.org/.* git://git.yoctoproject.org/git/PATH;protocol=https \n"

and execute
  bitbake fstests -c unpack

You should get something like:
  tar -xzf .../build/downloads/gitshallow_git.yoctoproject.org.fstests_e5939ff-1_master.tar.gz failed with exit code 2, output:
  tar (child): .../build/downloads/gitshallow_git.yoctoproject.org.fstests_e5939ff-1_master.tar.gz: Cannot open: No such file or directory

What happens is that the download step generates the tarball:
  gitshallow_git.yoctoproject.org.git.fstests_e5939ff-1_master.tar.gz
but the unpack step expects the tarball:
  gitshallow_git.yoctoproject.org.fstests_e5939ff-1_master.tar.gz

The difference in the tarball names come from the different url used in
the recipe and when rewritten according to PREMIRRORS.


The symlink solution would add a symlink from
gitshallow_git.yoctoproject.org.fstests_e5939ff-1_master.tar.gz to
gitshallow_git.yoctoproject.org.git.fstests_e5939ff-1_master.tar.gz.

The recipe-url solution would name the tarball
gitshallow_git.yoctoproject.org.fstests_e5939ff-1_master.tar.gz.

> > Now the question is which solution we should implement. For us, it
> > is
> > the second one (tarball naming after recipe-url). It comes with the
> > downside that the one mentioned test fails and has to be removed.
> > In
> > a
> > real scenario this results in downloading a repository twice and
> > having
> > 2 tarballs with the same content. But I expect this to be unlikely
> > in
> > a
> > real world scenario.
> > 
> > A third solution may be that we add a link between the download and
> > unpack task. But this would be the most intrusive solution for
> > Bitbake.
> 
> I'm more than a little concerned about the symlink comment since the
> fetcher assumes that symlinks work in other places too.

Sorry for concerning you. I think it is no issue. We generate the
tarballs and archive them on a system without symlinks. Then we get the
tarballs over http with the help of a premirror rule. We do it as
described in the Bitbake manual chapter "The Download (Fetch)". I
expect this to be a fairly common use case.

Another rationale for the recipe-url solution is that the mirrors are
used when the server from the recipe-url is not available. When we
generate a tarball, it would be strange that the name of it depends on
some local conditions (closed ports, local mirror rewrite rules, ...)
rather than the recipe.
This probably invalidates my argument that the symlink solution is nice
since it has the same method for naming as the git clone naming. This
are 2 quite different use cases.

> Also, do you have any new test cases to add which illustrate it?

I have a test but it is a bit tricky since there are 2 issues. The one
you see (as mentioned above with Yocto) is actually not the real
problem but an issue that is only seen in this scenario.

Since I am now quite sure that the solution where we use the recipe-url 
for the tarball name is the correct one, I like to reformulate my
Question: Do you see a reason why it is a bad solution?

If you don't see a problem I will implements this behavior. The failing
test will be replaced with other tests that capture the new behavior.

> Cheers,
> 
> Richard

Thanks,
Urs


