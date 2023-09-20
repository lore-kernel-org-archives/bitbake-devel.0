Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066B3CE79CD
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 11:15:08 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.89])
 by mx.groups.io with SMTP id smtpd.web11.35613.1695208504932497030
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Sep 2023 04:15:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=MvPN8k05;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=MvPN8k05;
 spf=pass (domain: arm.com, ip: 40.107.21.89, mailfrom: ross.burton@arm.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj3AsRLepDRDmsagKZ1uTsYQpCxTtZJ2LWuXu4Uivos=;
 b=MvPN8k057SK+Ul0eCDkGjxtDgt+Mj4MNmRntR4RakkT+Y6HJVo1otEY4YELcSLHetGwbhsQcCT85UOO1ZvA3FcIxRTgdP0EtR4tT7bRpP1oiHHojRMEWrvNZ46BOk2IKOmdDVMqZjQzYRifI24MfS6h9TVarQNgvjI6396yBohs=
Received: from AS9PR06CA0698.eurprd06.prod.outlook.com (2603:10a6:20b:49f::11)
 by AM8PR08MB5761.eurprd08.prod.outlook.com (2603:10a6:20b:1d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 11:14:59 +0000
Received: from AM7EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:49f:cafe::90) by AS9PR06CA0698.outlook.office365.com
 (2603:10a6:20b:49f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 11:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT014.mail.protection.outlook.com (100.127.140.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.16 via Frontend Transport; Wed, 20 Sep 2023 11:14:59 +0000
Received: ("Tessian outbound c99fbc01d472:v175"); Wed, 20 Sep 2023 11:14:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7a833e0716f6b74f
X-CR-MTA-TID: 64aa7808
Received: from 5d84047aa2f4.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2CD867B7-8CDA-4695-8ECB-038CBFD19DE0.1;
	Wed, 20 Sep 2023 11:14:52 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5d84047aa2f4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 20 Sep 2023 11:14:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHipTPKdivtOPKpcf3k6sZ0jdcNE2vNyu+2CPn58g81V6vncPAtheIiKis426lFM84t9N5Upy5J2DB6URpyfy0i/vKyNVEl9edgI334kR/1KacZ8vfA7Ge+s+gXivu1kjann7SHBcHT3vs3SfSOv/jN0EXzU7AsckWer369jgFzU/3vHhHCQdgo52IKqQz2djC2ZOgAQoou1aUbK7aV/2hUn3tlLSu3+5iYAcoar4Ar5i27How87A6J54JkuGILsbJtooGt05fx8dLUxX0SSuT0Zo/0zvepg6zPwFGMmrtwufPjHV4GW58ISaPDk+rte/ynd7AnQduCBxC+pvsPgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mj3AsRLepDRDmsagKZ1uTsYQpCxTtZJ2LWuXu4Uivos=;
 b=m1HrTEVkbfYAOurpdLl79zlB29OQVKK/cChljP/eDmhY0eyFrAbqPajaGr+PifbHgp9vUjkVagXG/KKctZ+48dEGxO8+D6XhdNvktbumn62ZIDT2I3uNoOYq8qVZs6PsAHlfKfzWdzRYzmEIqDMMPCYFq766f7MIbTUkB0Y0hKcShJNkF0nKytHfYNmPgtxht3/fg1Q2WEfYsEj33ZjIHjD7AlCUK++AVzCnauRVVZIRf+DKnAZkF6qE7vWxPyhVb1vEh7KXK2ub6MTKuDA1AtofiIuNSlgQg4ogMW/GDKBPvP6HmhMLJMuNkQbFcIyq8dwTQWXkaQBg81K60MDdLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj3AsRLepDRDmsagKZ1uTsYQpCxTtZJ2LWuXu4Uivos=;
 b=MvPN8k057SK+Ul0eCDkGjxtDgt+Mj4MNmRntR4RakkT+Y6HJVo1otEY4YELcSLHetGwbhsQcCT85UOO1ZvA3FcIxRTgdP0EtR4tT7bRpP1oiHHojRMEWrvNZ46BOk2IKOmdDVMqZjQzYRifI24MfS6h9TVarQNgvjI6396yBohs=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AS2PR08MB8926.eurprd08.prod.outlook.com (2603:10a6:20b:5f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 11:14:49 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::4b8a:7518:c642:5727]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::4b8a:7518:c642:5727%7]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 11:14:48 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "ecordonnier@snap.com" <ecordonnier@snap.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel][PATCH v3] avoid some unnecessary copies
Thread-Topic: [bitbake-devel][PATCH v3] avoid some unnecessary copies
Thread-Index: AQHZ65Xyyv5VJYsIS0KnNxXveKluHrAjkB0A
Date: Wed, 20 Sep 2023 11:14:48 +0000
Message-ID: <3AB5AC5B-3E05-447C-9708-8716143BFB67@arm.com>
References: <20230920074148.4047337-1-ecordonnier@snap.com>
In-Reply-To: <20230920074148.4047337-1-ecordonnier@snap.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AS2PR08MB8926:EE_|AM7EUR03FT014:EE_|AM8PR08MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae25740-234c-4ecc-7fc2-08dbb9cad3fb
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 o3zRWR2LeW34wtjrcFVJH8dLI/5ms1ZWu/qngDOz1a9e142cHogfxlNDqCl73SY75y1dV/zEkPE8/OCiDbkm2RU6Ap2DCFZHZsVi0KwAaQ8pKWnx9YfxsANH1OiDHirGL4h4s1fna0B9eyTY1YKqt3U8GVzr1UT/5eyuRmYivGiyHo1+ATblVifEVhQjKJoLf366k6spypz3/swejtU6yCD5jfogq6qIsIMRM+upvVX0PJml3fG5jGkSIMWvKChycxpEtFEci9h4NWcY4U+ASDMx41BxdVHVnPRTaD7AzCIN6ZXUWuSj6w+0AoXSWazj5PuKZlJEymJlfonYi9a1U/KCnHou5izGUcSZofUxwXtw7JfcqkRwOYQK/9KBt4kuWmK9zntXpFmbYawVjqS0jOuhNSaXu3tZh8PdS4PVVfShMulS2RCwUq1bXpPgQp+fPFClwfr2Fd2gkg3TFTKNWBP6LtWlasQ9LFDSUsZ8Wj3fuJO5S0ToxTAxY+IWL/+GZhOAHulUcOcZDXED301hr+FERyfTKeQ19/1rpUIn8c80RQgKgTyludZIffwWBnc7oQaqsW6lnrKY3XXObCXPuyc2r0IpxabNIqO9sgVwKeN0gtzwlyXVK+ytFJJE9qQzr+pDpDnhb/nsdDyc71zFmAK2si4XRyp1E7N0wSBp3Io=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66899024)(8936002)(8676002)(41300700001)(26005)(2616005)(478600001)(6512007)(6506007)(966005)(53546011)(71200400001)(6486002)(36756003)(86362001)(122000001)(83380400001)(38100700002)(38070700005)(33656002)(66476007)(4326008)(91956017)(66556008)(76116006)(66446008)(66946007)(64756008)(2906002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D21CBD5CAE986B498244B68D167EAB62@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8926
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM7EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	1cf307a9-5339-4d92-4a05-08dbb9cacdb7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8m+6y6BqZdQ8bdilyIT3m60eBAC32nihKpZfssCGrf+Ok/QXfzJOMUi3NULb3N/PyL30tfiByZf7yLgdPoeCCwq2eIoFjF+VyU1xhTry9SAv5fbB+FsWxf1Vu44nEhZLUcWwn3WubgjyNNGGU/OTDMq0rbHsAOkhsUUojFTl3RxBMhDBS2qZFrvfHCb3qfQfmIQU0NlAvsiEHElk6rBeChnmp9BzCOtV8+5j/jYDzKhdGVX6Adbt+QK9NQs0yZ98Yhv3Iiwoqkpo6n4TrqATQF0agsRjPdCUHZwRWg/lTJy1xWdSb4q0qW01eRWQDvvTlYRChYFUq7d8rrPQXztYYqOh5UQGuVrjmoSYNFGZvLJLSOHV9KH7P8SGuvN8e1nAOdrN/OR/5Dy6RAKZMD8Yq850PZJYYDMVox+3l5BIgUk0DZJUu8oATxsokNPevK5kfgr9PtY9L6ztHPMfvbsdQGEVhbQ5aZLPY0GsR6gqFLPMit1ygHhM1Z2LBL34LnYShPg06RV6H1AWhtOSv1ZWvhKAokQ6eMgSqTs+rkX6OU5PZ3YgV9cmjZfyMM3a+b1YW6DcUpAa+ZGhru9R6gv8YUcw1gpiKfTqpnab1K7X9siI0uoFz7yqR43DqBOZPUfwlHc5VawNeYqan/ZcbJ9pDosNIkfoEjWr0Imky25kWBFOdowQPabZ2YgDeAGx72MZiq9BGeJJeTpZvoOa5O68sev3zZZ6BiF6awFKwnVOIVAAsm95R+Libb9AVlKInE02wAM0tRN6hs/AijoA5C30aQ==
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(53546011)(6506007)(6486002)(478600001)(6512007)(83380400001)(8936002)(8676002)(70206006)(70586007)(966005)(316002)(5660300002)(40460700003)(66899024)(2616005)(36860700001)(36756003)(33656002)(82740400003)(86362001)(6862004)(40480700001)(4326008)(2906002)(47076005)(336012)(26005)(41300700001)(81166007)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 11:14:59.3439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae25740-234c-4ecc-7fc2-08dbb9cad3fb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM7EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5761
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 11:15:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15089

When sending iterations, please add a note explaining what the changes are.

That said, solid improvement, well spotted!

Ross

> On 20 Sep 2023, at 08:41, Etienne Cordonnier via lists.openembedded.org <=
ecordonnier=3Dsnap.com@lists.openembedded.org> wrote:
>=20
> From: Etienne Cordonnier <ecordonnier@snap.com>
>=20
> declaring queue=3Db"" creates an object of types bytes().
> bytes() is an immutable object, and therefore doing "self.queue =3D self.=
queue + r"
> creates a new object containing "self.queue" concatenated with "r".
>=20
> On my test setup, we are passing 180MB of data of "workerdata" to the bit=
bake-worker,
> so those copies significantly slow down the initialization of the bitbake=
-worker.
>=20
> Rather use bytearray() which a mutable type, and use extend() to avoid co=
pies.
> In my test setup, byterray.extend() is 10.000 times faster than copying t=
he queue,
> for a queue size of 180MB.
>=20
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
> bin/bitbake-worker | 14 +++++++-------
> lib/bb/runqueue.py |  4 ++--
> 2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 451e6926..609e276f 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -91,19 +91,19 @@ def worker_fire_prepickled(event):
> worker_thread_exit =3D False
>=20
> def worker_flush(worker_queue):
> -    worker_queue_int =3D b""
> +    worker_queue_int =3D bytearray()
>     global worker_pipe, worker_thread_exit
>=20
>     while True:
>         try:
> -            worker_queue_int =3D worker_queue_int + worker_queue.get(Tru=
e, 1)
> +            worker_queue_int.extend(worker_queue.get(True, 1))
>         except queue.Empty:
>             pass
>         while (worker_queue_int or not worker_queue.empty()):
>             try:
>                 (_, ready, _) =3D select.select([], [worker_pipe], [], 1)
>                 if not worker_queue.empty():
> -                    worker_queue_int =3D worker_queue_int + worker_queue=
.get()
> +                    worker_queue_int.extend(worker_queue.get())
>                 written =3D os.write(worker_pipe, worker_queue_int)
>                 worker_queue_int =3D worker_queue_int[written:]
>             except (IOError, OSError) as e:
> @@ -346,12 +346,12 @@ class runQueueWorkerPipe():
>         if pipeout:
>             pipeout.close()
>         bb.utils.nonblockingfd(self.input)
> -        self.queue =3D b""
> +        self.queue =3D bytearray()
>=20
>     def read(self):
>         start =3D len(self.queue)
>         try:
> -            self.queue =3D self.queue + (self.input.read(102400) or b"")
> +            self.queue.extend(self.input.read(102400) or b"")
>         except (OSError, IOError) as e:
>             if e.errno !=3D errno.EAGAIN:
>                 raise
> @@ -379,7 +379,7 @@ class BitbakeWorker(object):
>     def __init__(self, din):
>         self.input =3D din
>         bb.utils.nonblockingfd(self.input)
> -        self.queue =3D b""
> +        self.queue =3D bytearray()
>         self.cookercfg =3D None
>         self.databuilder =3D None
>         self.data =3D None
> @@ -413,7 +413,7 @@ class BitbakeWorker(object):
>                     if len(r) =3D=3D 0:
>                         # EOF on pipe, server must have terminated
>                         self.sigterm_exception(signal.SIGTERM, None)
> -                    self.queue =3D self.queue + r
> +                    self.queue.extend(r)
>                 except (OSError, IOError):
>                     pass
>             if len(self.queue):
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index c88d7129..c40a3be2 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -3159,7 +3159,7 @@ class runQueuePipe():
>         if pipeout:
>             pipeout.close()
>         bb.utils.nonblockingfd(self.input)
> -        self.queue =3D b""
> +        self.queue =3D bytearray()
>         self.d =3D d
>         self.rq =3D rq
>         self.rqexec =3D rqexec
> @@ -3178,7 +3178,7 @@ class runQueuePipe():
>=20
>         start =3D len(self.queue)
>         try:
> -            self.queue =3D self.queue + (self.input.read(102400) or b"")
> +            self.queue.extend(self.input.read(102400) or b"")
>         except (OSError, IOError) as e:
>             if e.errno !=3D errno.EAGAIN:
>                 raise
> --=20
> 2.36.1.vfs.0.0
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15088): https://lists.openembedded.org/g/bitbake-deve=
l/message/15088
> Mute This Topic: https://lists.openembedded.org/mt/101474114/6875888
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [ross.b=
urton@arm.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


