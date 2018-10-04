Return-Path: <chris.laplante@agilent.com>
X-Greylist: delayed 38933 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 04 Oct 2018 15:10:38 UTC
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
	(mail-cys01nam02on0077.outbound.protection.outlook.com
	[104.47.37.77])
	by mail.openembedded.org (Postfix) with ESMTP id E6F1275264
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Oct 2018 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=sRIcUZioyTWqRlUk+8lTyz0zxRbSxGfZk55ecjfaEO0=;
	b=SnRVfDKumc+d9z0/jixrrozM0opplGZ1j2aAEGC/ydRxA1mYUMErv5wQEOlgmWYr6D6wdkeDUekOoc19ZfN1bs6k9/MzBSLjLZZXDiBhIooFVgh5fm0wWjF0/ruA+DWIKwuRq0+VrpcPA8rE0u8bU7jCEVfHF4LwAUy6ehnhwqg=
Received: from MW2PR12MB2540.namprd12.prod.outlook.com (52.132.180.159) by
	MW2PR12MB2491.namprd12.prod.outlook.com (52.132.180.146) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1185.22; Thu, 4 Oct 2018 15:10:38 +0000
Received: from MW2PR12MB2540.namprd12.prod.outlook.com
	([fe80::91bd:ada6:4938:2a6f]) by
	MW2PR12MB2540.namprd12.prod.outlook.com
	([fe80::91bd:ada6:4938:2a6f%3]) with mapi id 15.20.1164.029;
	Thu, 4 Oct 2018 15:10:38 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Fixing bitbake --revisions-changed
Thread-Index: AdRb5kPJyTfO7oh8SCObHdEtPG/3YQ==
Date: Thu, 4 Oct 2018 15:10:37 +0000
Message-ID: <MW2PR12MB25406C73DC67507911E948168BEA0@MW2PR12MB2540.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [18.234.18.239]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR12MB2491;
	6:nZDxZ7IStX8pMUyKs6bOJX9r8kSMW0Zrl53LkP5pbddZ4TKvqiC4ci8CKIn3Hjzueetd0V86i3j3NRN+6nHF3z0ZSQ7n5eikC+I+dlFz1nW54LwnsatPTW7zPgDLt+6ktnxqVHQXc9crqKk0gO6/rm0btsO0VOeChGqWPfekWBt6/BDy0Co/IjDXDYDPFtT4Hpv6YuVHXsIbPKUFchrnjCrukgsxDjnv1UrjSPuENwx7jgxaQ9psYx34ae9w63pQegXvedfh+N616GDZnilHCslnV6OzkBPonhaUPCoWBKzFGyci8S068+E4VpqGmULoO6Lj7OVFzN/KjGSSQLAYU2aAWwhXBX9Y5QQFkroctWP9IIdthyZSsVUtvyD2usotzVe6+8IL7+a1ngZwzeeP3ChrWoIVb9RkDGYnALqibKwCrg9IWnFdJvChpFMRvRNhGoPoaGAXn5Igj+kIb5SPfA==;
	5:waoZyzz24qVLh3pMLPGKtQbJGJ94aeo1AHytIW1crSWC8OZWOLfslipXPoQdabntTybjbjo7+/zMLpJvMr91qyafppEQtzjW9YQCRxQ7OCtx11BJdrt+LGFRwYXiuNv+73PQ1OFSd0rqTFxzuRFHaGSynxOtR5bGdDfRUm9DwHI=;
	7:9qlWVfqRFtg5vNmAFaFxuSHJqbwL4Lw97U2HIisnoA3YE918g+0CAeE4z7nhf2LboJO9nBHQWzcY4lHs2opZImJQrySN8qdlDLbSRee88bSLug+2o6EeRM24ZDtpp6VAdfgrx644tO8bimp0E4H2d3bpAM6W8Tu82haVmnd0fhwJhfmncQtCXiYJzvIG/O8mGkzW0bc5k/NuhQDDufLEdDUCf2t3JoBhZEq5XVuXaU9j6fXAYjfc1NjRPjJai3Vu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 55fb12d5-7b88-45d3-1aff-08d62a0b8ac3
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:MW2PR12MB2491; 
x-ms-traffictypediagnostic: MW2PR12MB2491:
x-microsoft-antispam-prvs: <MW2PR12MB2491436E16C474EA4FE81DDB8BEA0@MW2PR12MB2491.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(158342451672863);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201703061421075)(201703161042150)(6042181)(201708071742011)(7699051);
	SRVR:MW2PR12MB2491; BCL:0; PCL:0; RULEID:; SRVR:MW2PR12MB2491; 
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(31014005)(29502001)(53754006)(189003)(199004)(498600001)(68736007)(106356001)(86362001)(55016002)(5640700003)(5250100002)(9686003)(2501003)(5660300001)(2900100001)(97736004)(186003)(305945005)(53936002)(6436002)(99286004)(81166006)(74316002)(71190400001)(2906002)(476003)(8676002)(33656002)(6916009)(81156014)(71200400001)(256004)(102836004)(25786009)(486006)(7736002)(6506007)(6116002)(105586002)(7696005)(14454004)(8936002)(2351001)(26005)(66066001)(3846002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
	H:MW2PR12MB2540.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: Og32mifQTsP3edKTDVv2RTnU4Xq53mcxnNevpqaj7Zi9j8lC8lsjk5GQUomEyxsy2kezS26x0DgXuJVsyB4RLWgFfkecI2LkzuLFidkmn7HpudZfmZvXBbWRrnJWY5VohK9zLWtBvVt4MpdimaWJ1q3wBiwRzIYbFcadtCSg9dL6sanNFcZC0Th3Ne1wM5iDFUvXUFqyfijSlOFn3npxu9n64Ql2JBh/cn/IVZYmMk10rItByo5Y//RafW8hcqMQ8uo3FfAT7VAZk2QgjQtkVUxTvzDnjtz0DU0o5GX1RoBQoL9Io4nxNLKxbmdsehs7J4yUHYb9GfXcdXDIPYAiZO6GlufmuSz+00M/ClLdccA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fb12d5-7b88-45d3-1aff-08d62a0b8ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 15:10:37.8990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
Subject: Fixing bitbake --revisions-changed
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
X-List-Received-Date: Thu, 04 Oct 2018 15:10:39 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

A while back I wanted to use the --revisions-changed flag of bitbake but fo=
und that it was unfortunately broken. In the next week or so I hope to subm=
it a patchset to fix it. There are 3 issues preventing it from working, whi=
ch I'll detail below. I am not sure how to fix the third issue, so that's w=
hy I'm starting this conversation.

Please note that to reproduce these results, vanilla Poky isn't enough - no=
ne of its recipes use SRCREV =3D "${AUTOREV}". So you'll either need to add=
 a recipe (or layer with a recipe) that uses it.


1. Bad call to bb.fetch.fetcher_compare_revisions

The first issue you'll encounter if you try the flag is this exception:

    ERROR: Command execution failed: Traceback (most recent call last):
      File "/home/laplante/poky-master/poky/bitbake/lib/bb/command.py", lin=
e 116, in runAsyncCommand
        commandmethod(self.cmds_async, self, options)
      File "/home/laplante/poky-master/poky/bitbake/lib/bb/command.py", lin=
e 723, in compareRevisions
        if bb.fetch.fetcher_compare_revisions(command.cooker.data):
    TypeError: fetcher_compare_revisions() takes 0 positional arguments but=
 1 was given

BitBake rev 81bc1f20662c39ee8db1da45b1e8c7eb64abacf3 (2016) mistakenly drop=
ped the 'd' parameter of fetcher_compare_revisions. The sole usage of the m=
ethod (in command.py) still correctly passes it. So the fix here is easy - =
just add back the 'd' to fetcher_compare_revisions.


2. Incorrect handling of bb.command.CommandExit in knotty.py

After you've fixed (1), and if upstream changes are "detected", then compar=
eRevisions (command.py) will call command.finishAsyncCommand(code=3D1). Tha=
t method will fire bb.command.CommandExit. Assuming you are using knotty, y=
our bitbake command will hang forever. This is because the knotty CommandEx=
it handler does not set "main.shutdown" (unlike the CommandFinish and Comma=
ndCompleted handlers).=20

The fix here is simple - the CommandExit handler should set "main.shutdown =
=3D 2" to break out of the loop and return its return code. This is in line=
 with how the ncurses UI works (it exits the loop for all three flavors of =
events).


3. bb.fetch2.saved_headrevs is always empty inside fetcher_compare_revision=
s, because fetcher_init is called twice.

Now we get to the part we're I'm unsure of how to proceed. In (2), "detecte=
d" is quoted because as we shall see, fetcher_compare_revisions will always=
 think it detects changes.

I will assume BB_SRCREV_POLICY is set to its default "clear". fetcher_compa=
re_revisions boils down to comparing these two sets of revisions:

    data =3D bb.persist_data.persist('BB_URI_HEADREVS', d).items()
    data2 =3D bb.fetch2.saved_headrevs

If you instrument the code with some extra logging, you'll find that data2 =
(and therefore bb.fetch2.saved_headrevs) is always empty. The problem is th=
at fetcher_init gets called twice. I'll reproduce just the first part of th=
e method:

    def fetcher_init(d):
        # ...
        srcrev_policy =3D d.getVar('BB_SRCREV_POLICY') or "clear"
        if srcrev_policy =3D=3D "cache":
            logger.debug(1, "Keeping SRCREV cache due to cache policy of: %=
s", srcrev_policy)
        elif srcrev_policy =3D=3D "clear":
            logger.debug(1, "Clearing SRCREV cache due to cache policy of: =
%s", srcrev_policy)
            revs =3D bb.persist_data.persist('BB_URI_HEADREVS', d)
            try:=20
                bb.fetch2.saved_headrevs =3D revs.items()
            except:
                pass=20
            revs.clear()

Again, let's assume BB_SRCREV_POLICY is "clear". The first time the method =
is called (during server startup), bb.fetch2.saved_headrevs is correctly se=
t and BB_URI_HEADREVS is rightfully cleared.

Unfortunately, fetcher_init gets called again later by runCommand (command.=
py). The sequence of method calls is command.py:runCommand =3D> command.py:=
updateConfig =3D> cooker.py:updateConfigOpts =3D> cooker.py:reset =3D> cook=
er.py:initConfigurationData =3D> cookerdata.py:parseBaseConfiguration =3D> =
bb.fetch.fetcher_init.=20

In this second invocation, bb.fetch2.saved_headrevs is again set based on B=
B_URI_HEADREVS. But the first call to fetcher_init cleared BB_URI_HEADREVS.=
.. thus bb.fetch2.saved_headrevs ends up empty.

----

I'd like to hear some feedback on how to fix (3). The "easy" solution, I th=
ink, is to do something like this to ensure saved_headrevs doesn't get over=
written:

    if not bb.fetch2.saved_headrevs:
        bb.fetch2.saved_headrevs =3D revs.items()

fetcher_compare_revisions is the only thing that uses saved_headrevs, so th=
is shouldn't break anything. Alternatively, is it better to change it so fe=
tcher_init doesn't get called multiple times? Perhaps it should be split in=
to a fetcher_init and fetcher_reset?=20

(Another side question I have is whether we should/could modify fetcher_com=
pare_revisions to work even when BB_SRCREV_POLICY is set to 'cache'. That f=
unctionality would seem very useful to me. That's probably a topic for anot=
her discussion thread though.)

Looking forward to feedback.

Thanks,
Chris

