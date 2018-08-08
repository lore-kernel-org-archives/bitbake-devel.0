Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0089.outbound.protection.outlook.com [104.47.2.89])
	by mail.openembedded.org (Postfix) with ESMTP id CB28378BF6
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Aug 2018 22:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=/D8d5eNJc9PrLUdA4PQ+xugY5+o00nURe22bGti1eaQ=;
	b=b0apM90us6J+hKdgDMM2HfrpBnmfdmmt8q4GCnyq1P6kbwf9B4bz6kNJfEBK2nwF3d7OGvWv0zb1mKFXwqwxMgB/0HSbcy6zx+rxTHmWIR21PoNPc+FjgSoXLkXjQ753oFXfYZ7Lgtkcuch1TMgAW/yMAl3Cvf93oJgcTD13yb4=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon (83.173.245.202) by
	AM6PR03MB3832.eurprd03.prod.outlook.com (2603:10a6:20b:24::26) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1017.18; Wed, 8 Aug 2018 15:41:24 +0000
Message-ID: <1533742880.21568.13.camel@bbv.ch>
From: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 08 Aug 2018 17:41:20 +0200
In-Reply-To: <1533278893.3333.1.camel@bbv.ch>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
	<3bace14d7cbf7d350b146849d6f9eefc00fe9733.camel@linuxfoundation.org>
	<1532509053.6506.9.camel@bbv.ch> <1533278893.3333.1.camel@bbv.ch>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: VI1PR08CA0119.eurprd08.prod.outlook.com
	(2603:10a6:800:d4::21) To AM6PR03MB3832.eurprd03.prod.outlook.com
	(2603:10a6:20b:24::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f63a401e-a42c-443d-3e41-08d5fd456605
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB3832; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3832;
	3:GDKRHsgEufVGbYZLhq1y1GYThy00g/ULR1/Mjwcg0ZpW0YkXkZRdq2T5MhkdksVMP9VEseN7aqr9ypuho7pXvX0ki9+YnvWYMdgJdBpT9SNKap9hohcEnlsiQeXg/fdqzfqVSTbGgT3+ACusxkhlAYVTuXxYqCVPYfHIPBljJubOSOxdUDJydhjxn4x4RY0RxC4AMIiZTnlPBYjY5LAowif/KW3X5kNClQ1YeUzHRj//1b9h6T0YlRHEhZ5rmDoM;
	25:oeohuObAig3uAdA8DB7bxCTSnZtj9GYhZE98tPeM0D+swhIhiSUhcc9uyawOHfPFmB3ipx1xxKGDz2GWgRhheRGnyanIVKzYd2HsuD/+RG86p7OBgz3VxwM7Li/NgecFvclOznIClcpa3ONi7Z6giEe0Y8D041nEajajYDV8Zel6bU4x6gGKyjd29/Y80zaq/wb286q4LcaVaVxC5X47we2T3eWLr8YsrHZudu3QxWWI2yXLem5fWALpkF+B3sVZ7FY1Plp+vBnzJBs0m5pcDK0pHbiBPATpxfJnPc5OsgsBuRVRjDxAay5kAaCMTr8yC5REwMWVnhVdrZgj7Dje/g==;
	31:eRQBWmNIw9BAGcxorDbzsQLEOX8X1pOZhKn+1KA84Rutn427FD1lUi2myg3NuE5QHTJmPRyhh/icBAU1a1K+PQyzr3AO3cjx3t9zEE8HK/aEkmCfO9iRHvUgvgh3yq6659S/MHHLAKg9O2WFdctWlTYS2bmQputLEPdS3gIlcs8N5/0pr8uvYZmvLTfdD7QW7RsY9ZOUAOGGYSXlirsh57mLx99E4zykdeqRxo+XndE=
X-MS-TrafficTypeDiagnostic: AM6PR03MB3832:|AM6PR03MB3832:
X-Microsoft-Antispam-PRVS: <AM6PR03MB383282CAD33816A2C96336978F260@AM6PR03MB3832.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);
	SRVR:AM6PR03MB3832; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB3832; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3832;
	4:G9G6JKwLGy736JqYno+yZq4LeD5MufVX7/bQMadzkp/MDZ31vB2PhhPwVfOuhW7OHUw/igF05tyu0Mc10Tgb7+BcCqlBAD/g128LBbU6Uxxlgs+wHK5ETkCzAPc58iVYRYGFYfp9kNux0pEt/AesDXKkxmw90JRhgh64+zgx4DbODcrUuyR+rCsClHUjgKt+usiHdV8WwhaeNRgmHzWfMGPJUeKDs5u89G5C61v9tnEAv+Fk7qkIRjgE8Ek7qOoT7IjwpNAKziGhbM1up0wLm/rVgbYdXZPJlir4h6tzy+BAnbzsGjpGj/ZQ7vHj8I8Z
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(376002)(366004)(136003)(346002)(39840400004)(396003)(199004)(189003)(53936002)(103116003)(345774005)(8676002)(26005)(81156014)(316002)(105586002)(186003)(6486002)(16526019)(229853002)(81166006)(52116002)(6666003)(23676004)(7736002)(106356001)(6496006)(25786009)(47776003)(66066001)(386003)(14444005)(305945005)(74482002)(93886005)(33896004)(956004)(2616005)(3846002)(97736004)(5660300001)(478600001)(476003)(68736007)(5820100001)(86362001)(2906002)(2870700001)(11346002)(446003)(6246003)(486006)(36756003)(50226002)(76176011)(50466002)(8936002)(6116002)(99106002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB3832; H:talon; FPR:;
	SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjAzTUIzODMyOzIzOjFDTHF3OHhjNVRZeFBzSWwwK1RmZDFTLzdl?=
	=?utf-8?B?RWpQakNhYXhKd3Y0Z0pXSCtPNGY0ZFRpYm1iSGp4eGt2cUdka1RRU052aUh6?=
	=?utf-8?B?TjhzWmE2NnlqbXJsZnFOV21lSXlnaml6ZTlQUWdNQ1RhTEVhSWJ0cDZsSjZX?=
	=?utf-8?B?Z09RWTlmU0tzUVJlNWlqYXRybE1tdlpBZE0xV3JMc0l0andTYlJwSWpnSGxP?=
	=?utf-8?B?RzM3V05GR3BtNzllNDVOK1ViNklkUjFzb2xLZVBoK3dKYmgvU2JtK1Yrelhs?=
	=?utf-8?B?QzMxYVIvNHY2SDBOaWR4dnBiSlFHVWVWN3VTYnFQTXhmMmkzTStNMjY2Wkkv?=
	=?utf-8?B?eVc2WU1IUU5hZU5xd3NtWXlRaWJ1VGJrZUxoMnM3MnRDWWZhTFNBMm44MmJT?=
	=?utf-8?B?VDZueWsyTUlSS1o4OGQ0UVdQcUdoNkdMQzl6TS9LSGxIckl5RHg1aFZtY1hR?=
	=?utf-8?B?SGdRS2xvaldISm5WdUNxWmlYTTFSUS9VdHJBazkrT1FGUkUxVm14aUhGaVZR?=
	=?utf-8?B?RTdNSStyTGdkazBLTUhFZjQrdFdkQ0NjSS9CeW13ckFVM1FmTUZCcUFtMnBk?=
	=?utf-8?B?L2FyeDl3ZW5idy9wS0lUSVU1T0FaOUhma2paU2N6bWg2WjhlbkJrbDlvUDVN?=
	=?utf-8?B?MHlvOGozc1l6M2FldXpteVVyZ2l2ZmwzUVJFenpwK1VtZ3Juak80MEU5bkFh?=
	=?utf-8?B?SElnbnFDNS9oNW95MzRFQkdpVGxUV2pjKzJrWTNYeG5nNHp0RVlSVlhTU1d6?=
	=?utf-8?B?UlovVXNTV05jaWhEellHZGhhY213Wm96RFdxakp4bnJhUDlhMHFpK21Cdkgx?=
	=?utf-8?B?blF1RWRoV2VBb2h6MVRDZWlZbkQ2SThhdHpoQ0U1MnFIeXk5WHFDanBjYjFS?=
	=?utf-8?B?c3B6MlJFclBnc09VYkhZUUNhWFlNQ0UzMGRhSEw5bDM5SGl6YUNDOFNJeDhk?=
	=?utf-8?B?MkJWSmtJeXhzd294d0hBRXVyTXBTT1pSa3ptOTVJbVZ1eG1URlBxZXRKNXpl?=
	=?utf-8?B?eWJIWVBCNTJmV0pXdWoxNjFGSURZNVZId01XNEVMczV6a0NqbHRSUmZsVmgz?=
	=?utf-8?B?YXlSdW9QTTkwOExnUkNGbkVCYVZ4SFJhUjM4V3BqVkdYNFR3Mm5ZWFNxWkdm?=
	=?utf-8?B?Mkx6ZlBUVkIxa1NxbW5xeFJmSDdPajZDakhsSWhTSmRjT2NQSjYydFNPUnEy?=
	=?utf-8?B?Y05UMHJOb0FhSmkvcU1hbjFmdzByNVVZWExOOUttNmlDckJsZ0c4K3BLQTE3?=
	=?utf-8?B?c3ZWR3JZcnd2V1R2WDh5R2dqL1FRU09adExtczczTjZBZHlYWS9neDNiWVJF?=
	=?utf-8?B?a2haKzI4YzRFaW9lOTRUNVpYWlJic1lHOXpPZHZzdzdSdmNnSGk3L3Eydlcw?=
	=?utf-8?B?TWZwcVU5L3JOclRRL1E4cGRjRVZuZWsycjdWQS95bFVodkV4ZStYWi85WXVR?=
	=?utf-8?B?b3ZXSXJieGg5dlJsbzN6N01tTmVrU0FSa3lKd1VWYnZTTHVEK0c1VHcrSjF0?=
	=?utf-8?B?aWxXSWRjS1dUTXZjMjBoZ0E2K3JlRVNucjN3eFA2K2VheWpzQlN1YnpZTWRz?=
	=?utf-8?B?c2UreVE5S2luTVhBVWtuYlpRdlRXcXBsYWZFN0krOUhLTlQ0dnVYMkNWdlA4?=
	=?utf-8?B?SDlCS09wYXZjTnc4UjRrT2xyUFk1a2ppVHJlT3c1c0krTWhVaUtBcHJnWUd4?=
	=?utf-8?B?azdydEdBTXZMNHpFSE1yNUYzRkJ6RUltU3VJQld4bm1CcE55SmZCOHJMcm1u?=
	=?utf-8?Q?nYgvLwb9FPzPgq1M7RdmvsorhydfmZHsAseEg=3D?=
X-Microsoft-Antispam-Message-Info: hBpCyGREyMXuz6zGyzXwNiPqp4Uskg+QB412AUsAYZmrbskH7NkP6Eoopf2+arraZY/JxD6aQMyj2mITkF0tQ03QPatZotOdlyDMz6MCQbFDdbQdIh0zG3QB9+b+GA6O3U63ZDNl5+F0FPFnx02R8uS7s+2uKUFqdjtgtE+/MzzlzeyCc63SPjq5Wm7r/gce2GS5RgZNgmnvnpLXqOoBWNqkIQpzyB8Hw+Wxc7ApQY5hSqKp+HIaoku5W6okMQVTJgRNCiqQhT1FSRmYV/WFPxppvTSQAHJjkMHH5v6zj5cv2QLa3aIrAAkNB5hFqS0ATMUehR/SWXY/TzIjIpMnwSmXDiTiwYxhdSQ+D/L3cHw=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3832;
	6:yCxh9Z3Y68kJm09psdExqBFQp63QEvCreQr2cvleSQYWJIrX56izpfYesy4Fm349wLAPBj0G8uaFjXclD+K+ne2KgGz9I7XgpnVUnOkX0S3/xdZPNPArP9JfTTf8d5rMmwmuSHiW1Hqd6g6EFzi1lrvBQL1BrSsNzt75K1lWPCT60lKnPsof8vGVqgDqnI9Ns1+UZK+WYiB+h5uyfkmUCrkipFgEYiMCkG+81FDjaJl9aqQvLJC/Qfbebolo29dugIClBdCCOoULIeG8uOJmYS8NK/iA939vazlS8hJkY3iFxZcZPkhCWpmJPSx3bFKbju6SuQXtsQakb9VLd7VzozYMdjE0Gp7MTd4sNASe3hy+I8D0bSrJ2YRz9lb/z+OqGmdRqCuKNDQv3Q2gYmELwvaHmld94V7+D1IcyrDC5R5KJgTA7b8Kp1WqpilVjcZqhjQA/AbipTRmrQ0jBa+Qxg==;
	5:u2aeVgVhHRk0jyYyFUHEEG3snbrm/m1nB/1+Macjj407phX83GO8wDSmyh0nmAhQscdphm1xZOHpI0RjaaqcH2bNdTJ/DOdBZ0QdGKB5iL+Z4aCcfQSIvN3QCOlMcvNbJu/kyWRNEgnj4lz3GIHACOvLE0Z/sT6/gH6TDOx0D+Y=;
	7:b7IXW11oouVE3g7crAmtCHSZPkhcr6aV3CnkwJUx0ZhZaovvGEKwqzdYxKrdwAdeovjKhXkwOXe7d1gymbqyWbIBK42E17fbKS5aTiadTPG9jLDQs6pwZ3SG4bU+E3fXjrBp884YaUyujLTegsunTeoN/iiDYHum1qcCDSPk1GX0YqFcPl0/uubvhNOb7FEAGpylPOedttbNkV4mGl5z5yo8nX+n1Mj0mwi0Pn8z8KsXk/2vuI0sH4cS77QejOd6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 15:41:24.6796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f63a401e-a42c-443d-3e41-08d5fd456605
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3832
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3832;
	23:M6isFsntc5AKiFmgs6LtvZST/jT24VoAx3IICKKCC2YpckzkDjGguoAhX6MzFh0JbePknuICtwY1rJ3cIx4KaL+0dFw5KOL3fidLJvUESLi7LRzw96619FrSqhzdh2P3iWnOk8dXIkVBfGO4U6xveA==
X-OriginatorOrg: bbv.ch
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
X-List-Received-Date: Wed, 08 Aug 2018 22:40:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

ping

On Fri, 2018-08-03 at 08:48 +0200, Urs Fässler wrote:
> Hi Richard,
> I have improved my patches but like to have your Input before I
> commit
> them. Please see my questions/reasoning below.
> 
> Thanks
> Urs
> 
> On Wed, 2018-07-25 at 10:57 +0200, Urs Fässler wrote:
> > Thank you for your feedback.
> > 
> > On Mon, 2018-07-23 at 23:00 +0100, Richard Purdie wrote:
> > > On Mon, 2018-07-23 at 17:42 +0200, Urs Fässler wrote:
> > > > The existing behavior was to use the url where the repository
> > > > was
> > > > cloned from.
> > > > It happened that the tarball was not found when a mirror
> > > > rewrite
> > > > rule
> > > > was active.
> > > > 
> > > > We now use the url specified in the recipe to name the shallow
> > > > tarball. It fixes that the tarball is not found under certain
> > > > conditions. In addition, the naming is independent of
> > > > network/server
> > > > failure and the mapping of the name is easier to understand.
> > > 
> > > I'm not sure why but throughout this patch series you've used
> > > function
> > > names and variables prefixed with "__". We don't do this with any
> > > of
> > > our other code so it seems out of keeping with the rest of the
> > > coding
> > > style.
> > 
> > I will fix that.
> > There are methods in the git fetcher (same file) that are prefixed
> > with
> > one underscore. Is this the way to go or do you prefer no prefixing
> > underscores at all?
> > 
> > > With regard to the function "__has_up_to_date_clonedir" you
> > > added,
> > > its
> > > very unclear why some checks would go in that function and some
> > > checks
> > > would go in the other. The commit description helps understand it
> > > a
> > > bit
> > > more but that doesn't help the function naming or someone looking
> > > at
> > > the code in future.
> > 
> > I will fix that too.
> > The difficulty with this one is, that the use of "need_update" is
> > most
> > certainly a misuse in this context. I can improve the patches to
> > make
> > the misuse more clear, but it changes only a bit on the end result.
> > 
> > I am planning to resend only the patches that handle the cases when
> > the
> > sources to unpack are not found (up to Patch 5/9 in this series)
> > first.
> > The patches to solve the root of problem will follow separately.
> > 
> > > Finally, I'm still not convinced that passing around the original
> > > url
> > > and forcing the original url naming into any mirroring code is
> > > the
> > > right solution to the problem. I said that at the start and
> > > looking
> > > at
> > > this code change, I'm still not convinced this is right. Part of
> > > the
> > > reason I continue to believe that is you just added a N*N testing
> > > problem to the fetcher where the fetchers now behave differently
> > > depending on two urls passed in rather than just one :(.
> > 
> > Maybe it helps when I describe our use case and problem.
> > 
> > Our Yocto build machines have no access over the git protocol to
> > the
> > servers. We use mirror rewrite rules to use git over https to
> > access
> > the servers. Some server provide the git over http repository under
> > a
> > different URL as when accessed over the git protocol. Since the URL
> > where we cloned the repository from is used to name the tarball, we
> > end
> > up with different names of the tarballs depending of the
> > availability
> > of some servers.
> > 
> > To be able to build our Image years later we archive the generated
> > tarballs. One way to store them is to use Amazon S3 which does not
> > natively support symlinks. To be able to access the tarballs from
> > S3
> > over http, we use a mirror rewrite rule.
> > 
> > At the moment we have different scenarios where it fails, all of
> > them
> > a
> > bit difficult to reproduce. The common root of the problems is,
> > that
> > the tarballs are not found because they are searched with the wrong
> > name.
> > 
> > I support your point that the same things should be solved with the
> > same mechanism. But in our case, the tarballs are not the same
> > thing
> > as
> > the local git clones. From our view as Bitbake user, the local git
> > clones are Bitbake internals whereas the tarballs are artifacts we
> > get
> > out of Bitbake and use with third-party systems.
> > 
> > As a Bitbake user, I expect that the name of the tarball only
> > depends
> > on the URL I specify in the recipe. I certainly do not expect that
> > the
> > name is different depending on the availability of some servers
> > since
> > this is a transport layer issue.
> > 
> > I think both solutions (symlinking tarballs and using recipe URL
> > for
> > naming) solve the problem equally. We prefer the recipe URL
> > solution
> > for better compatibility with third party systems.
> > 
> > But then I see that the symlink solution is the one that nicely
> > fits
> > into Bitbake. I have to check if this is a feasible way to go for
> > us. 
> > 
> > Cheers
> > Urs
> > 

