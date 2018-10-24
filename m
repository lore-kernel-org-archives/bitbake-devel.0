Return-Path: <chris.laplante@agilent.com>
X-Greylist: delayed 23762 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 24 Oct 2018 21:35:00 UTC
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
	(mail-by2nam03on0084.outbound.protection.outlook.com [104.47.42.84])
	by mail.openembedded.org (Postfix) with ESMTP id 51420745F0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Oct 2018 21:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=HLCKrP63bQjUcV5dFcODNebFWRq4hYJBJ4Ta1rFnSOc=;
	b=Tyy+3XGm2QRlNtuty+/05EY1GKX5WYUtD857vkt3gZY/F3bbAnjPG+6CJfNUks0HcrMa+WizBjxNmX50RlLz+yuxtkfO352NVXVVi7lF3wV9zNHkNLRCHUHY6Sk7aMbcoyl6la1YGjJOvrSHiP2c3AG6jsLy1B1Jg0tmyZ89k6w=
Received: from MW2PR12MB2540.namprd12.prod.outlook.com (52.132.180.159) by
	MW2PR12MB2348.namprd12.prod.outlook.com (52.132.179.159) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1250.29; Wed, 24 Oct 2018 14:58:59 +0000
Received: from MW2PR12MB2540.namprd12.prod.outlook.com
	([fe80::91bd:ada6:4938:2a6f]) by
	MW2PR12MB2540.namprd12.prod.outlook.com
	([fe80::91bd:ada6:4938:2a6f%4]) with mapi id 15.20.1228.035;
	Wed, 24 Oct 2018 14:58:59 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Fixing bitbake --revisions-changed
Thread-Index: AdRb5kPJyTfO7oh8SCObHdEtPG/3YQPw4msw
Date: Wed, 24 Oct 2018 14:58:58 +0000
Message-ID: <MW2PR12MB2540F054C8943A69D129B0DC8BF60@MW2PR12MB2540.namprd12.prod.outlook.com>
References: <MW2PR12MB25406C73DC67507911E948168BEA0@MW2PR12MB2540.namprd12.prod.outlook.com>
In-Reply-To: <MW2PR12MB25406C73DC67507911E948168BEA0@MW2PR12MB2540.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.59.252.60]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR12MB2348;
	6:/JrnXc8zut7M/Hm52HfHBnMVl4TX3kyHqaBwB8td+LjRfuqAnYvb9D0RT+8pBj5YkihUt86R5LHDAVfQ00tX/sEDJ1tqIQl5pT5X0e/Xp5/0FyTMMcQ7L9egI2agWgCu/o5Xi1x8oPf+Kk0r5jdWAYveFAvilpdT9P2RbOoLqm2rrkahPmebr80+YRIl1J324VqacWfzE30kP0XR9hvOzoyY3s41CYVRmZ5Rpc3a5BTk276iFl82wt2P6B2PrG/QEeZFYL3gbjDhVTOhNCEHXzb/lamnxneCJ0IJ5NElT1a4m8B+b1LQHsCW2WVsiV+re58eJcmDueEP2EJld/nbBgfaHYiGlBGfGXY1DICoOAwHbIBve3W7XjaZVUf9Q5TJTYNSYh/hRr7X3pm0i1G+l1JcanUbSa4YJ3pKX5hJIZW2UWwQP6rWCR+9Ov/s5pEIcgMXwUNa9xQkkeSZ+SA4xw==;
	5:GNqc8Yog/u/AEOCweM7uxZFoESYV+IbQwy2px7Iu13C72JWjNRIhsaCs6OfDYMd5nMOQ8QDj8OszOm63gPEUkgaaJXtK99Rz56VtWMum9X7e+viBUU7C8v3KvC0NKYKUWU2YlQ6VI96THd7qvJdCmLE6eNUEq/kUSsni5dpIiQ4=;
	7:8AcmSt5eWOBRk6Q7cug6tJWxxvu6ZPGbVbTtA5qs8F4KkbOXiqEjIRipKPeA7GE1iGQNJr/hoMcE/OxpXHXTsroCogZ2Dl2yVPCouS1x+96m+1KqYur40g5WzW5oDkcwlSknzgQ/w9hh7sqxrLGQGJhxbrJ3y4IsRVeO7ElHF3gOLW8VfGit1hdDDzrPBR6snf/RI6ES0m/FH+H0xtqDA3eKc3K7leN/+grFf73Vtj4soAKqGEr+KKL5EkDCbRaD
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2c64f101-e603-45cd-e70c-08d639c13a64
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:MW2PR12MB2348; 
x-ms-traffictypediagnostic: MW2PR12MB2348:
x-microsoft-antispam-prvs: <MW2PR12MB23489B79B3E46D143EB026D88BF60@MW2PR12MB2348.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(264703809997249)(17755550239193)(158342451672863); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(11241501184)(944501410)(4982022)(52105095)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
	SRVR:MW2PR12MB2348; BCL:0; PCL:0; RULEID:; SRVR:MW2PR12MB2348; 
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(13464003)(31014005)(199004)(189003)(29502001)(53754006)(71200400001)(2351001)(106356001)(8936002)(86362001)(8676002)(486006)(25786009)(186003)(966005)(102836004)(305945005)(6436002)(26005)(6246003)(55016002)(9686003)(6306002)(5640700003)(53936002)(33656002)(5660300001)(476003)(14454004)(446003)(6116002)(97736004)(2906002)(11346002)(3846002)(5250100002)(7736002)(105586002)(6506007)(74316002)(81156014)(81166006)(2501003)(478600001)(6916009)(68736007)(229853002)(76176011)(71190400001)(7696005)(66066001)(99286004)(316002)(53546011)(1720100001)(2900100001)(256004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2348;
	H:MW2PR12MB2540.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: JYnBHdUfByhe7p41P5pB0SRSLrQ5XoQA7oy4JIDFEOORMjnrFjlidxIiUDkLwCK9eYdK3jw39hA/axNeeDePkAeGKOBgHP7/vvVycYVujAGsjv1DCUA9m4iCqcATikxC7ORVFw5kOVgBY94WFzS0ux3QCe425hir3Lxr28e7HYCYSS2Q1uh627g8WkR6FMb+phnc7naKoRcCgF1CZIuyCgD+/BSFgJe/c62xv0PEbzu+lyJJQW8S/y9KtwhNpZYJEwni8T8VmWsG1B+ApSWAlsRWwBLJ6ERm0V7TWwZWhZU61MSrSI41mA0lpWn2rB69KoFkGnYpTcUcjghIRFYYLDOw/WkVNPrrutS5DdUMZnU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c64f101-e603-45cd-e70c-08d639c13a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 14:58:58.9855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2348
Subject: Re: Fixing bitbake --revisions-changed
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
X-List-Received-Date: Wed, 24 Oct 2018 21:35:00 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

*bump* - any feedback on this?

Thanks,
Chris

-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-bounces@l=
ists.openembedded.org> On Behalf Of chris.laplante--- via bitbake-devel
Sent: Thursday, October 04, 2018 11:11 AM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] Fixing bitbake --revisions-changed

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
--=20
_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel

