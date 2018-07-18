Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0044.outbound.protection.outlook.com [104.47.2.44])
	by mail.openembedded.org (Postfix) with ESMTP id E324D70100
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jul 2018 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=zJ0kq4CPxHk58Jb+1BRhP0Nyjd+135ECfrrT/RycM5Q=;
	b=FM/f+i85A9d319idzfPVLU48ZgK1tPXjBkJ4y5Wm03/WQSrx2MvbP7x8Plo4GeYApgaRLU+Uzj3DVnQzMMd8FPEN1ajM1jBOI4uwjrHHXdq82RmZP2TrZ/ak5opD9H1/QPCsiE6CiUv6uSk1T8RHSZmlz8SRB0LyzhqA3CUXrfg=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon (83.173.245.202) by
	DB7PR03MB3835.eurprd03.prod.outlook.com (2603:10a6:5:30::21) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.952.21; Wed, 18 Jul 2018 12:38:31 +0000
Message-ID: <1531917509.2962.42.camel@bbv.ch>
From: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
Date: Wed, 18 Jul 2018 14:38:29 +0200
In-Reply-To: <8afc9bc960e469d4e243e7512a0285c2dd36a584.camel@linuxfoundation.org>
References: <1531826153.2962.36.camel@bbv.ch>
	<27b7bf4b1cd46e051b3c9c9e109ecacf6f238336.camel@linuxfoundation.org>
	<1531834769.2962.38.camel@bbv.ch>
	<8afc9bc960e469d4e243e7512a0285c2dd36a584.camel@linuxfoundation.org>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: VI1PR0102CA0054.eurprd01.prod.exchangelabs.com
	(2603:10a6:803::31) To DB7PR03MB3835.eurprd03.prod.outlook.com
	(2603:10a6:5:30::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05f8fc64-9859-46a1-5c97-08d5ecab5ea7
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:DB7PR03MB3835; 
X-Microsoft-Exchange-Diagnostics: 1; DB7PR03MB3835;
	3:642OIlzU5f7r54SvjDv0iXUL++ZgoJE+IAoeUT07ceyLvCVQ/3ctlwXeMlWuAJyUqHIMk78f0HlI/Xb113tf8wo6L18sEVEjwotCqXuP3RyIIN5rfB+aatm7TfrLszObw7RD45s/x4X+VsmEFWTtpFjHHWr5UhmXix5NIBiM12sUj6ri8JeqnYELtFwIPSSuvpu/JGT4t/iiGlwSfwRWzRHuNYBnA06XyFQMcrToJWEX2gCIPfVHl0BsPAWXZ383;
	25:5ScUzdQzGz+RYY7UEvEKT5bFEKeg5Ez2kx13Ge2SfwOitRE2bDeqbazTPLwYecuKgZ8l4XKXMlB2OLaza4SnjmWgARSUnGrSkCZxHLlRVZ7nAaaNHb9oZKXcHDcD+NE0C7lksZEAj60KWgU0/+m8gKqSscczwfmBOw5VAeFwa/OYaS2qJVDY/+4a7/mk/mTcDtioUxMWGDcIp4bpVcbv/BQ68o5No3KyMUzAOfD/SvfcL+bpl2ElPU1In1duXcVv4RUF2c3oRtT/63COmabL+225oxgLnmR+hTTZsROrnptYu1J/Ztv3YqQboqOL6hskS/ECVxdU/RmTVqvZWvOk/Q==;
	31:CIJXQ0dw6CSCzS9F3EKMvhWIer1Za21U/iH/hK3PEsTt0Li2VyMPbEUHIEU3vpc4blDIhTP2fAd8OY3LfCeaHJewAphn3W3GHj8VDxc/nUfO57FeCx0K9roP06Vd5bgqdX55gBEOEkkJIbMQu8cXjttQNRke8b0gHBUMCaIfEAMOLI5HaeGyWf6eBB8t/E1zwEq0+UuXTQLoaPh8zRXdEBza3+Tpdki/HiSMkWk1IYE=
X-MS-TrafficTypeDiagnostic: DB7PR03MB3835:
X-Microsoft-Antispam-PRVS: <DB7PR03MB3835048D770BCAE25ABBEDE08F530@DB7PR03MB3835.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);
	SRVR:DB7PR03MB3835; BCL:0; PCL:0; RULEID:; SRVR:DB7PR03MB3835; 
X-Microsoft-Exchange-Diagnostics: 1; DB7PR03MB3835;
	4:DJ66mGZ7GzNREesOpL/HEVNeU0nTyn+Kn+lmU2wgupoV0n0B1cq1TmYDxl16TZkE8E8fDwJxvFhNrOPfjd6D2Vy1qyAiPO3yjHOdygKDmlxhlVvUoBK9bVRAK55FodQIZY+LhNvpsm+GpidE52IPtFZmYyCukAi3f5Q4RMZyCMNKlqZYdLNiliWGPfxVPgm2JXzIJxg9NWOMHKPc2qw5aQryFRfCdegBGq4KCsxkpirt7Y6P1q0iIiOlbO8y0sLUemWZemHPytTc0tu1jw/goWGT8LFqwLUDAyzu+EpdHhQ8ta0fmO6sNhfhvL+jBZo7
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39840400004)(199004)(189003)(2870700001)(305945005)(86362001)(50466002)(105586002)(68736007)(14444005)(7736002)(5660300001)(97736004)(2906002)(74482002)(23676004)(6496006)(4326008)(26005)(6246003)(106356001)(5820100001)(53936002)(186003)(50226002)(8936002)(103116003)(6116002)(76176011)(476003)(16526019)(81156014)(386003)(3846002)(25786009)(446003)(6486002)(52116002)(316002)(11346002)(33896004)(47776003)(93886005)(36756003)(956004)(229853002)(8676002)(478600001)(2616005)(486006)(81166006)(66066001)(99106002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR03MB3835; H:talon; FPR:;
	SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjAzTUIzODM1OzIzOkZDNjhETi9BT3NrbjF6T3RNLzJVV2JUeEF5?=
	=?utf-8?B?ZHJhRTQrQVFyZml5MUwwbHd5bVZPZStVaVpOQTc3SThKcFM2MWU3UVQxSnFY?=
	=?utf-8?B?c2djdjhPQlltWEJHZFVpRUxxbnVzZHI5dndJMWZBa0FnaXUwYm9vam9zeGR5?=
	=?utf-8?B?K0RycGZ1SEt6S3RZTzlqWUg2eFRHQ3U0bTV5dTRtRHVXbnA5ME5SYklsQWxO?=
	=?utf-8?B?VnlHd2t2b1k3d0pmOVFYa3ZCOFRkMGpZVW5vNUxLaXZaMy82ZlMwd0xjODY3?=
	=?utf-8?B?VWJPOW5PazVRNk1jN2x1SVVYLy9UZHFHUHRZYjlHZFlRWXkrMVlWK0FJVW5X?=
	=?utf-8?B?WVhJb3VUNWp2T0Mwcko2Mk13bEg0SkNuUWRkQXpyaWtMem1YRHlwNkNNS3VZ?=
	=?utf-8?B?dlZDRFkzcnV2MWUxZS9oR3NzeUFJSjhMa1VKV2U4L2haWGRYcWZUNEpVKzZh?=
	=?utf-8?B?UFF3ejRqNFZQTWZiR2JTL2gzSk1Hc3cvNjRRRzdONW5WK1RTZWd6dUVMMnZX?=
	=?utf-8?B?THhEZ0N4dWR2UFVFZUhYRGRDZVJ3QTBtOXVlNkJyazNlaWw4cDNpL0dBVHdy?=
	=?utf-8?B?WXM2QS9PYS81MHZMeEZ1SGtsRVdIdVFZbzVmWEJmZEdmcWk4NWxDeTY4NVh2?=
	=?utf-8?B?Nlp0Tk13RlAwUTJaMDVHQm44K0doVm9uRXZtbWJlZktwRHMrWDk4ZWNublFy?=
	=?utf-8?B?SjlrWndCSFo1eWt2TVhSM2w1TlBaRmhYKzRHVlJ0dXZlSzZkS3d4eWxtcFRI?=
	=?utf-8?B?MjBQTUJlYTkwZmd4RnRuS00xcXQ2MHk1T3VDeXduVnhjTURVc05XdURVYyt5?=
	=?utf-8?B?ak94TkFnY3VkQnpHZlk3cElhb0VZa3VtV2x1K1hLTmhidTJJSTRBYjRBa09R?=
	=?utf-8?B?cUVCWThyV1ZzZ0YrTVZ5ZUdhdXg0dkhITWhjTW5IVWJHeUdhZExvUVdrUTZD?=
	=?utf-8?B?THJkMjU4VVVtNU1kMStUNlcwcklYYzVpbmNnMEwwVklEbkYvNk83OTNWcHQ3?=
	=?utf-8?B?UzltWHVEdmN4V3I0K1F6TEhMMHZXdEI1MWtPUUtHcDJJc3lnYnJvcTMvanJY?=
	=?utf-8?B?OHdxQUdSSDU0ME15MlpXWW95eFc3eDAzU1NUeGtlZDAwbkVpYzhxRmVvY2d4?=
	=?utf-8?B?M1BkaVc5MVVHdEFBU3d4eU5OR05xZ1FWbkljZzVUbXVEQ1pxNVdqZFh4bXp0?=
	=?utf-8?B?ek56Wi9QMk94QnlqMGwwMVVZRURrQTZlSU1UOFA4UVB4NnFzd3U1OW9DRmV3?=
	=?utf-8?B?Vmc0WGpJOVZrUCtXQ2VkaUpxY3pCNHh5ZjJHQ2FSdFV0YlhWbEZwaDVzdG1q?=
	=?utf-8?B?UHptZVJucVNncldFSjNoOVc1ODd0R2JMQVhiT0R3dDAyUlhITFhzSFNSNWhv?=
	=?utf-8?B?K2lMdGdVVVlYdmNwRC93SG14REVDdFNzSkxFUks3YllZWWNJNmlQY2c2dHVy?=
	=?utf-8?B?L2k2R2ZoUWZLUE9qb0FyS2kya29wak1XTllpdCtwUXVJVTNRUjRoQWtFVzVO?=
	=?utf-8?B?OGRYNVpwRi9sRTN5RXhvenRJdFVUandtZVhsdFkzUnBvRU1yTUpLMjVKb2Zq?=
	=?utf-8?B?R3NZKzR6UWlHZ2ptYTBrZlUwNWtzQ2ZRTk4wNHg5S3V3NVhIajdEb25SaDVU?=
	=?utf-8?B?SzFLdVBsc1FvYktzdGU5WU9qZkN6VDU3L3ZkWVJZMTlZZFJFNUU2OGsyVUw4?=
	=?utf-8?B?RllmTGMzeHd6Z3F3Z2JtbjQ1bGQ2ZWdZdGZGc0E1aDZJTENpcFJVUjY0bDl3?=
	=?utf-8?B?WVd5QWxQUG9Lc2JDY0srZz09?=
X-Microsoft-Antispam-Message-Info: 7PYuC3+nJgI6T2fK3Wj11oa2Qx8uNh0DmBZm20/ZtugCwAssmeegWtLxcXWV7+3uf3jArAf7oRKD7eKCgkW+93TMMmqiZ51JV0uTKgBosVAT3cyPp5tEfa+HBjldwS0B9bdMhpAas+ad34INs1aqGTG9X9xGlPBlr6DP/GOHtzoBG3pIO4RNt4aej5zIUvp/S7Tl9eLHV7+yeIm/B2LJYswZE7mg/szowZh/UcTwZZ/mWTJZ0OmJsMHjwHjDEO9oAeTPtqeNK3KRbER4HoxmUusvOTqYHhLic/b6pF+2SyeiBWtlhAXQ3HXD6lW10SESLj5EjZKAvoXPArxkwXxcxviGfsurPE5z0ncgnorf7K8=
X-Microsoft-Exchange-Diagnostics: 1; DB7PR03MB3835;
	6:Nfg8JbABmeVYAkgThEQPzkk3rkZhncS5iPN8XewOTFVX4c69k24Z41cFgzz8FyyRlhTbwWVESvUo3fLsX5ttQzNf02tJl2ph4pSm1qpghDVORD4/bxtKC7Updg22JHlq+8rn+MjGbmTMFyMyirT1T55E7UHqrV85OqCXb72df9oYwq1aX8QbpkW8gDj6BzROTGbJM4iPTXhABbA+twVpcfQWJWQ7tyOdgArGjNFWS+I04QcxocbHY69tmxBeiZPM9q7rNS/VBjtGiVtgseh1UP02EuvYbC43ydLKs4elN1kIyYAC6aTP2lNINF6GwP5viAt2oSNGgCEj+6qyBi8UQ730772etPAmcoHbjpFjKHCo5KgGii29jWOvrPrh39j12c6MUg6rFLvU16YwPpE5JjYIJ5E59/WcVjNd0QyU/R3db9kRyesvhNY1acTyGRrvm7XtkqfD3vF4NjfdmnlTBg==;
	5:QXSaLejMri0eGAYBDQDeGzbWTp0EjWA5K4+DWzmp4TZfN58gDGk8JAtx9Dsw8b4SF+oyzJ9X7xem1FUL5vbAihfjFU0tBr+wLBDGHh08RYAdpX5IDKptc2H5GHGuiwJMQx8LIZjM9ow9gBBGjwTpeBA9kD2qrPdifJsJfO/G148=;
	24:fe5WKmBPzpqGK61nY/WHA7uFNbq8pu7ivSzXrK3AiNVI2jKBpRRas0AuigaCXk//rAAWGA4oWiiYf9rwnYCBzpTm0cL4CpT9Sf/uVa40q3Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; DB7PR03MB3835;
	7:K+zXf38x/apjtv69b4bVCUIya/fmZqp9kn1YTjQ7W+KRbbVqkSYBYGtIj6CodyTRP1M/qkuIhPN0IYlEOL7IBsnNXDQclXdcWr5ZO9hf0YljoX3kBJVC5h/bxmdDwfXzXkDV+mnwUxwxPnqBNRQJWVf3eaUvsUQ9OMzFO7yGm2ai7h2nfA099gEW3rL1k+PAWGaAOr2wd3HE2UUw3cS5ltT0fd0CRYcEEZXcZjKAP6jJ3J6zWvD3Tig04lPyHBKr
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 12:38:31.1020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f8fc64-9859-46a1-5c97-08d5ecab5ea7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3835
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
X-List-Received-Date: Wed, 18 Jul 2018 18:10:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2018-07-17 at 15:00 +0100, richard.purdie@linuxfoundation.org
wrote:
> On Tue, 2018-07-17 at 15:39 +0200, Urs Fässler wrote:
> > You can reproduce the problem with a current (rocko) Yocto. Add the
> > following lines in local.conf:
> >   BB_GIT_SHALLOW = "1"
> >   BB_GENERATE_MIRROR_TARBALLS = "1"
> >   PREMIRRORS += "git://git.yoctoproject.org/.*
> > git://git.yoctoproject.org/git/PATH;protocol=https \n"
> > 
> > and execute
> >   bitbake fstests -c unpack
> > 
> > You should get something like:
> >   tar -xzf
> > .../build/downloads/gitshallow_git.yoctoproject.org.fstests_e5939ff
> > -
> > 1_master.tar.gz failed with exit code 2, output:
> >   tar (child):
> > .../build/downloads/gitshallow_git.yoctoproject.org.fstests_e5939ff
> > -
> > 1_master.tar.gz: Cannot open: No such file or directory
> > 
> > What happens is that the download step generates the tarball:
> >   gitshallow_git.yoctoproject.org.git.fstests_e5939ff-
> > 1_master.tar.gz
> > but the unpack step expects the tarball:
> >   gitshallow_git.yoctoproject.org.fstests_e5939ff-1_master.tar.gz
> > 
> > The difference in the tarball names come from the different url
> > used
> > in the recipe and when rewritten according to PREMIRRORS.
> 
> Is this just a problem with shallow clones or with git recipes in
> general and the above was just a simple/fast example?

With shallow clones the problem exists always when using PREMIRROS.

The problem exists with full clones and MIRRORS, but is difficult to
reproduce. We think that the problem may depend the circumstances of
the first download (i.e. if the upstream or mirrored server is
available). It may also depend on the order of execution of the steps.
I will further investigate into this.

> > The symlink solution would add a symlink from
> > gitshallow_git.yoctoproject.org.fstests_e5939ff-1_master.tar.gz to
> > gitshallow_git.yoctoproject.org.git.fstests_e5939ff-
> > 1_master.tar.gz.
> > 
> > The recipe-url solution would name the tarball
> > gitshallow_git.yoctoproject.org.fstests_e5939ff-1_master.tar.gz.
> > 
> > > > Now the question is which solution we should implement. For us,
> > > > it
> > > > is
> > > > the second one (tarball naming after recipe-url). It comes with
> > > > the
> > > > downside that the one mentioned test fails and has to be
> > > > removed.
> > > > In
> > > > a
> > > > real scenario this results in downloading a repository twice
> > > > and
> > > > having
> > > > 2 tarballs with the same content. But I expect this to be
> > > > unlikely
> > > > in
> > > > a
> > > > real world scenario.
> > > > 
> > > > A third solution may be that we add a link between the download
> > > > and
> > > > unpack task. But this would be the most intrusive solution for
> > > > Bitbake.
> > > 
> > > I'm more than a little concerned about the symlink comment since
> > > the
> > > fetcher assumes that symlinks work in other places too.
> > 
> > Sorry for concerning you. I think it is no issue. We generate the
> > tarballs and archive them on a system without symlinks. Then we get
> > the tarballs over http with the help of a premirror rule. We do it
> > as
> > described in the Bitbake manual chapter "The Download (Fetch)". I
> > expect this to be a fairly common use case.
> > 
> > Another rationale for the recipe-url solution is that the mirrors
> > are
> > used when the server from the recipe-url is not available. When we
> > generate a tarball, it would be strange that the name of it depends
> > on some local conditions (closed ports, local mirror rewrite rules,
> > ...) rather than the recipe.
> > This probably invalidates my argument that the symlink solution is
> > nice since it has the same method for naming as the git clone
> > naming.
> > This are 2 quite different use cases.
> > 
> > > Also, do you have any new test cases to add which illustrate it?
> > 
> > I have a test but it is a bit tricky since there are 2 issues. The
> > one you see (as mentioned above with Yocto) is actually not the
> > real
> > problem but an issue that is only seen in this scenario.
> 
> Could we have separate test cases for the two issues?
>
> > Since I am now quite sure that the solution where we use the
> > recipe-
> > url for the tarball name is the correct one, I like to reformulate
> > my
> > Question: Do you see a reason why it is a bad solution?
> > 
> > If you don't see a problem I will implements this behavior. The
> > failing test will be replaced with other tests that capture the new
> > behavior.
> 
> For better/worse, the current fetcher behaviour with mirrors was to
> use
> symlinks to represent the path its resolved through. We use them in a
> variety of cirumstances such as when referencing local file://
> mirrors
> we can't write to.
> 
> My instinct is therefore to have all the fetchers behave the same way
> with regard to how DL_DIR works. Having consistency is important and
> multiple code paths with different behaviour has caused us problems
> in
> the past.
> 
> At the back of my mind there is some thinking that the symlink
> approach
> does protect us against some potential data duplication in the
> downloads directory but I'm out of time to work through that thought
> right now.

You are right, it may duplicate some tarballs. This happens when you
have different urls in the recipe that end up with the same url by
mirror rewrite rules. I expect this to be a rare case.

> Can you confirm if the normal git fetcher has the issue or its just
> shallow clones as that is probably important?

git shallow tarball: always a problem with rewrite rules, easy to
reproduce
git full tarball: seldom a problem, difficult to reproduce
git repo clone: no problem seen

> I'd be interested to see your alternative patches too if you have
> them.

I am working on the patches for the shallow tarball.

Regards,
Urs


