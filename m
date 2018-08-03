Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0054.outbound.protection.outlook.com [104.47.2.54])
	by mail.openembedded.org (Postfix) with ESMTP id 7ED7978E45
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Aug 2018 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=xczYuHFOEjtPwGoWHxJAo1BTogHEKwhBHKXVsFCD2/U=;
	b=KVPnXBvjTNFVQXp66G+CKMapH5vQTY3LL3GlzURMBbnnl/mXbGiq6Nt5IPD2g2pwIgWpKkptbe47Dom/jkPhlE0urXIc3FqDKVzNA6swyCdSV5lnSciOlKBu5XzHZM4CbmWVK7XBSOmbx7XZDsahPuT3Q6KxD/E8omTyb/bTdOY=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon (178.192.158.184) by
	AM6PR03MB3832.eurprd03.prod.outlook.com (2603:10a6:20b:24::26) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.995.19; Fri, 3 Aug 2018 06:48:16 +0000
Message-ID: <1533278893.3333.1.camel@bbv.ch>
From: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 03 Aug 2018 08:48:13 +0200
In-Reply-To: <1532509053.6506.9.camel@bbv.ch>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
	<3bace14d7cbf7d350b146849d6f9eefc00fe9733.camel@linuxfoundation.org>
	<1532509053.6506.9.camel@bbv.ch>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-Originating-IP: [178.192.158.184]
X-ClientProxiedBy: AM0PR02CA0031.eurprd02.prod.outlook.com
	(2603:10a6:208:3e::44) To AM6PR03MB3832.eurprd03.prod.outlook.com
	(2603:10a6:20b:24::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8457d7d-19ca-4eaa-860b-08d5f90d1768
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB3832; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3832;
	3:88S29T6xbQ177UT9yf9eG4aCaQLpIbwnrR3kwBuE3S+uZYxZip4GOFSCc1w1OBXZWRCd43fhTZ4RX9vvzh/2bjkt6uDHh386lmN1AJZy6ofG7LHN67Y+nmlQA7Jw0QkFkfwC/I4AF/xloHK5/EGfejnLhs5kszwaK85GA5Nlr/zb9/OZgtcN8lWvQ0FUPMS1ZfgdxabBWPnXGzdwbHIT/UYQMORiOdqYodmpr8avTEHv49vLp/Ea3m91qWfHJUXA;
	25:7vBX5ylyCOqZ2/sq2UVI/z71vtg9ugLMqGOweRjFUJ2rvFaUIYG22OnjVF0NK3+kssHBlD8B47SYyqhll2pnjqX26TUD6bLwW/pHEoQDp5r+Q20vAb6c1mwWCJQ699qFH9BFsFTGmRJ/dPy+Fc53ZxNJQyWhNt5pVVp6C1gEwvyry7jV4F3XETcEVofEu750BJKpvQADwVOH9gn5EpiyUKMsT7iR2+yeTXuVI6EQ4Egvm5+jZW7vhLJJKYJrUe+rKlEnVg5mR6s2gcquR+l0IqoPnim56CpAGTfycQl/4CC62FDtSfBLNOZ/zwYPlAKkaPezPFaGNlGSkyEKl6dcyQ==;
	31:oB64MEqv6ulQ1Djp+sKCCTP/QS89amYlkFYy7Gs8DAekRrpCvn346BUkCoY30cEyyWvyrCZAB7P6NwzZddNWdBxkG/xTmn4JXU1T3eFAYfAUCIiyeviHRPl7JHiPSzGgfaGu32c8AJ7mDSridK9ehRTfccYD2cnMlPHcZYJfe6pHmjHvXwmrb9Z0ctP2X+CJvlLrlAv5vdDmoDQz6MtD6M0+JnrP3ZHBbLWPogsiLys=
X-MS-TrafficTypeDiagnostic: AM6PR03MB3832:
X-Microsoft-Antispam-PRVS: <AM6PR03MB3832DA963A8181556D57D2348F230@AM6PR03MB3832.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);
	SRVR:AM6PR03MB3832; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB3832; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3832;
	4:fH6nyVdZhKDj5ESCtNTcWGIM5KsGOfRag82raM2CaGZbOfLTiHvSiFsaTD6C1+1dTBNyL2dQeH6CURpGc/2y/Pi6snQkwqDWXS07XHOnDQfx1Nh+mjLF+FSwAaLL0hJIE1lQv0zxoTmjGy6F6Bq/60K/l3dOv7hFn39m8ss+sglglTlJS+tWoCTm6/yaKT3byIuFXJnuoGJr3W8dJNGzYapgEnd/LviJFSKSwTeYe0eVwfDxybbfrdxxSwd4A97snTuRV8IOUceJJ4DdgeUZMnrRbnjnvMgTDuCOVv8FxxJQ1539+ygwGVgyW+ej8uTp
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(376002)(396003)(346002)(39840400004)(366004)(136003)(189003)(199004)(386003)(36756003)(16526019)(52116002)(66066001)(486006)(305945005)(186003)(81166006)(33896004)(47776003)(2616005)(7736002)(8936002)(86362001)(11346002)(8676002)(345774005)(81156014)(76176011)(53936002)(26005)(50226002)(6496006)(478600001)(106356001)(23676004)(14444005)(5820100001)(105586002)(476003)(446003)(956004)(68736007)(103116003)(6116002)(97736004)(25786009)(50466002)(74482002)(2870700001)(6666003)(229853002)(6246003)(3846002)(6486002)(2906002)(316002)(5660300001)(99106002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB3832; H:talon; FPR:;
	SPF:None; LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjAzTUIzODMyOzIzOmJjRkg2MXMvWERCeTB0c1RVWXE3MkR3WTlk?=
	=?utf-8?B?S3ljZ3d4ZGVpOHJkakFucXIyMWV5cDdpdmZNQ1RmY0Vndm50RXlHU3dKbUo3?=
	=?utf-8?B?OHRLREhRTjRvekt6NUQ0WityclNDVTBrcDhRYW9kcmM1VERwOHZDTy92WkN5?=
	=?utf-8?B?S2FZYXlEcVNScXNDbmU4N0l1OE93QTZoTks5anJ6dG52RCs0Q3ZQWkhFdEFj?=
	=?utf-8?B?TkhtRXEwRVB2bmpuVDFyRDlPSCsxaXE5MW9ZaUJVUlM5NWl1Wmt5WFpwWmpD?=
	=?utf-8?B?VTFiNlZHMWpTNE93RnltdytIYys4Uy9lUDQzRWlsSy9nZVlnK1UzSWYyZmFR?=
	=?utf-8?B?OUpPZ2lESDdNa2libFRDWWZEeEV6b2srLzJmdXFEWVk2cjJ5bEVqeU9lSWg1?=
	=?utf-8?B?UW8wRTFYV2F5NCs4ZTlsNFJ2UG05MWtBSCtQMjIzelN0OVJEMU1leW1oRTFU?=
	=?utf-8?B?bWtOQnFKeDJmcS9mZ3p0SzN6SXVIRk1GTEMyZ1NNQnpzLzJNbVZ6VU8wTm5U?=
	=?utf-8?B?Vkl6NVpablVIWmRuUkRmWWtKMXdReGVDbFVNMmplMjQzSDk5MnpPVVc4dkVk?=
	=?utf-8?B?ejNqQVowbFJuSHFEWVhmNmhtY3hPZ3JqcWRpekF1V1RsNkZ4ajNEZk84RDgr?=
	=?utf-8?B?eFp1WnFGb0p2WW8vTzBiY1pZUmhyWXhDR3FRMEwvKzFnQmxoYnBzQ3FzbnR4?=
	=?utf-8?B?ZHI5amltZ2JORWhJa2JwSWhjckY3dEdGRVQzRmk5NUpHMDJHbENIb0hLek1U?=
	=?utf-8?B?TW1UTTBZdkVOT2pVMklZWHduSVdvaFdkM0hGd1Y4Tk9RNkg0aUNLOExyZTBv?=
	=?utf-8?B?dWF5TE5aeFlNd0lLbThRUzBBZjdxM3ZEclhoSmo1UGdSMDRUVENyblgwamFP?=
	=?utf-8?B?QjZ5enIwSGlRQVJjVTAzZ0dVakNueVNsY2ppNWh1TGNGbGU2NGVGZzZiNGpj?=
	=?utf-8?B?OHNrY1FITHd6WThMZysreFVJL1ZuN3JzRW00OTRsclhPM3pPa2s2YjNtWGpi?=
	=?utf-8?B?NXpmRUluWCtKNWV5ZHAxM3UweWVwTGs3SXViUEJwSTlsOHhQM3MrQjZiQUZL?=
	=?utf-8?B?S0Eyc052VmQ3MVJLT1lhY1NTQ2JRMis1MkxHUlFJTGdpTDhPOC9TaUV0Tk1v?=
	=?utf-8?B?SlRtcDJzY0I3aGNLc3hoMGYvTURtN1J1ZHlVZFhPY0x2VTBCWnR5NHBtb0ZL?=
	=?utf-8?B?dy9kMnlmcUtCMzlZODVqK0Qza0VPZGk5cjRsd3drMjVwNHhZa0cwTnY2eGRJ?=
	=?utf-8?B?Nm53bzBLUzlFUVZZU2NwOVoyZURWK0JiUkdpV0kzL1VVRGpVRTluU3VKTXNz?=
	=?utf-8?B?cFoyMVJlWWJiVjVJaDh0RW10Mi9UdUc1bzJkK21WVVd0Vzg1M1QxV2VBMXM4?=
	=?utf-8?B?clpMaVhMaEVSVlVMQVNrd1M5ZXFNTnpXdzZ5c1QyTWZnN3FISXFucFVJSHVD?=
	=?utf-8?B?bnhhTHBNMXFRUmF1NVhLZ1NPSXpmSXQ5QjNHbE5wZU1OeDg5bFU2L0NkU2RJ?=
	=?utf-8?B?OHk0VE01N21wM3hzanB1R05vYndqK21pNDhkMlZZRkpDRlMvVGoxUlhoZFBF?=
	=?utf-8?B?WndsQUJUUUdKTWpFbWlWcTlaS2ZCZ1NmUFJXZTQ3SXM1c0JzdTlWdzdPa1Zu?=
	=?utf-8?B?bUpyS0IwQ1NSUVpNTnU2bG5ZbjE4SjJGbTg2TzVwbFlRSFUxOXRPMEhwTUxn?=
	=?utf-8?B?N2N1SGgyYkZLQmdkMy9BdFNZUndQWGtUc2VqbVNvMDlZMnVrTWtwTUZ3aVNW?=
	=?utf-8?B?bk51WFNSa2ZtT0NJdjZwUT09?=
X-Microsoft-Antispam-Message-Info: 9p17EpZatEUPKkK21/zBADxN/jO8SOD4BGtXyHfATYnWJiTPz17jJGG/cIsDRZIdcp21k9+ahkhmey7OuocTjHzxZEdbBkC/GE4tMJo8PBygzhILmYDzbIV32mvQBj+UszhdIoHyEQOl25BmdzBT4x8EQdyyHdTzUWNGtjHd4cin5ujY2WdtV0W99KrsISc91F2g1r1vYhCfzebBZbrUKSShA2Z1pQ0Bl6wqBKOmpvgjRvxtgX5ryCXnqgpAKJJXdn/rPlbB5bobHs3ye9le1d2i4XKzxqKY2IYtjmPvQR5/wh9eIlNMeMoICG4X7sS0zlqP6kepTqqrhSjuqqcbAQ+UreLB6MPpRhsugtbTz9k=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB3832;
	6:hcTq+e5fMmVjDGiduYEZHVGHDp/6WdnJsvz0WThsC2VPFJYl5C43UtQDgfDTJyC3Y/yFIDfJDtetuZS+3Lzi6FefK/nyKDUfu04RtLXMWlqh2MS/8L8L/2/xxN9k5eYCQ0KK4Xnuv7cStqZy1qXxRNzL/abbg01YqmPBjcps8dhf/SVjI47cAd+UKysG4OS5oYBJ67CLpeh6yNmvFrjFb9VkUkSi/lg1BP2b6AAIoJ9oQ84Nwobdepy3edxiPfaVcgnH2wsBcCsi0Bhf1HM2thdJ5AH/9BzRABKy6Pc22X9du4aNhqIaTbLI03QK1Sv7gfvvvOFgHEi94aE+EYg2kTm0Hl+i0Ci3dOVO47mKD1vZuJ3cH1k9DS+t82mr0GhXmVrIkKwqOQtZy6QRjBZXjinywS7Tmq1zasuhBMh5pi2RmwPPIFoIzmWlYD0c67GQxvACl5SE1n2bnFRD9S+F7w==;
	5:6WoyU2bfEc6Gqaxymz0W7kJlgcLbS3VoXY2lQE06zT9majKVK2+ExVJt79Mavv+PG7g6c/M3ikjXeXHs/OvxhJ4UnhAOTd390EZsC9cv4mwlIQTlxEVrjpTKWN/XUGKNuItHyMZU5L1ZrqRN/hvesKU1piupdYbCcuBNjz4rlgk=;
	7:w/16CVG5QlVPYRvMA0h8ZRHC69iPfS+blFY/M6n5JrfZT+AzP5h422GnSjaJOeSZDXOt8sTRF0X5xdH8K1KeEyJkQIPiWhKS1UnMVYwAZ1jzFPtaOvLmHcRZOGiheKC8cE+IYdAteeEW6gIHITgQKnsqjsFbxH3u9K3onc0kSglv9R9eATXZdxTz4DzGbUl/6gywNMugxl3a6izstQueVMwOv6tWsfCm/0GcRObfMUgXN8JkHE1UxnytCXdQX71Y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 06:48:16.3979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8457d7d-19ca-4eaa-860b-08d5f90d1768
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3832
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
X-List-Received-Date: Fri, 03 Aug 2018 14:23:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Richard,
I have improved my patches but like to have your Input before I commit
them. Please see my questions/reasoning below.

Thanks
Urs

On Wed, 2018-07-25 at 10:57 +0200, Urs Fässler wrote:
> Thank you for your feedback.
> 
> On Mon, 2018-07-23 at 23:00 +0100, Richard Purdie wrote:
> > On Mon, 2018-07-23 at 17:42 +0200, Urs Fässler wrote:
> > > The existing behavior was to use the url where the repository was
> > > cloned from.
> > > It happened that the tarball was not found when a mirror rewrite
> > > rule
> > > was active.
> > > 
> > > We now use the url specified in the recipe to name the shallow
> > > tarball. It fixes that the tarball is not found under certain
> > > conditions. In addition, the naming is independent of
> > > network/server
> > > failure and the mapping of the name is easier to understand.
> > 
> > I'm not sure why but throughout this patch series you've used
> > function
> > names and variables prefixed with "__". We don't do this with any
> > of
> > our other code so it seems out of keeping with the rest of the
> > coding
> > style.
> 
> I will fix that.
> There are methods in the git fetcher (same file) that are prefixed
> with
> one underscore. Is this the way to go or do you prefer no prefixing
> underscores at all?
> 
> > With regard to the function "__has_up_to_date_clonedir" you added,
> > its
> > very unclear why some checks would go in that function and some
> > checks
> > would go in the other. The commit description helps understand it a
> > bit
> > more but that doesn't help the function naming or someone looking
> > at
> > the code in future.
> 
> I will fix that too.
> The difficulty with this one is, that the use of "need_update" is
> most
> certainly a misuse in this context. I can improve the patches to make
> the misuse more clear, but it changes only a bit on the end result.
> 
> I am planning to resend only the patches that handle the cases when
> the
> sources to unpack are not found (up to Patch 5/9 in this series)
> first.
> The patches to solve the root of problem will follow separately.
> 
> > Finally, I'm still not convinced that passing around the original
> > url
> > and forcing the original url naming into any mirroring code is the
> > right solution to the problem. I said that at the start and looking
> > at
> > this code change, I'm still not convinced this is right. Part of
> > the
> > reason I continue to believe that is you just added a N*N testing
> > problem to the fetcher where the fetchers now behave differently
> > depending on two urls passed in rather than just one :(.
> 
> Maybe it helps when I describe our use case and problem.
> 
> Our Yocto build machines have no access over the git protocol to the
> servers. We use mirror rewrite rules to use git over https to access
> the servers. Some server provide the git over http repository under a
> different URL as when accessed over the git protocol. Since the URL
> where we cloned the repository from is used to name the tarball, we
> end
> up with different names of the tarballs depending of the availability
> of some servers.
> 
> To be able to build our Image years later we archive the generated
> tarballs. One way to store them is to use Amazon S3 which does not
> natively support symlinks. To be able to access the tarballs from S3
> over http, we use a mirror rewrite rule.
> 
> At the moment we have different scenarios where it fails, all of them
> a
> bit difficult to reproduce. The common root of the problems is, that
> the tarballs are not found because they are searched with the wrong
> name.
> 
> I support your point that the same things should be solved with the
> same mechanism. But in our case, the tarballs are not the same thing
> as
> the local git clones. From our view as Bitbake user, the local git
> clones are Bitbake internals whereas the tarballs are artifacts we
> get
> out of Bitbake and use with third-party systems.
> 
> As a Bitbake user, I expect that the name of the tarball only depends
> on the URL I specify in the recipe. I certainly do not expect that
> the
> name is different depending on the availability of some servers since
> this is a transport layer issue.
> 
> I think both solutions (symlinking tarballs and using recipe URL for
> naming) solve the problem equally. We prefer the recipe URL solution
> for better compatibility with third party systems.
> 
> But then I see that the symlink solution is the one that nicely fits
> into Bitbake. I have to check if this is a feasible way to go for
> us. 
> 
> Cheers
> Urs
> 

