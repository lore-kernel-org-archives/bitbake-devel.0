Return-Path: <Karim.benhoucine@landisgyr.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5478DCDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 09:06:27 +0000 (UTC)
Received: from mail.landisgyr.com (mail.landisgyr.com [213.95.165.69])
 by mx.groups.io with SMTP id smtpd.web10.203240.1697533577117538376
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Oct 2023 02:06:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: landisgyr.com, ip: 213.95.165.69, mailfrom: karim.benhoucine@landisgyr.com)
Received: from FRMONPC1175.eu.bm.net (unknown [10.49.130.40])
	by mail.landisgyr.com (Postfix) with ESMTP id 4F9341CF46E66;
	Tue, 17 Oct 2023 11:06:15 +0200 (CEST)
From: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
To: bitbake-devel@lists.openembedded.org
Cc: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
Subject: [RFC v2 11/18] hashserv: Implement read-only version of "report"
Date: Tue, 17 Oct 2023 11:06:13 +0200
Message-Id: <20231017090613.405588-1-karim.benhoucine@landisgyr.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012221655.632637-2-JPEWhacker@gmail.com>
References: <20231012221655.632637-2-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 09:06:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15249

Hi Joshua,

I don't really agree with your modification of test_ro_server.
outhash2 doesn't make sense since we're testing the case where a differen=
t taskhash (taskhash2) produces the same outhash.
In this case, there's no point in continuing to build, as the output is n=
ot modified.
To stop it, the hashserver needs to be informed of the actual unihash (wh=
ich is in fact the unihash supplied to the readwrite server).

The test should therefore be as follows:

    def test_ro_server(self):
        (ro_client, ro_server) =3D self.start_server(dbpath=3Dself.server=
.dbpath, read_only=3DTrue)

        # Report a hash via the read-write server
        taskhash =3D '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
        outhash =3D '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98=
fd7e5970796f'
        unihash =3D 'f46d3fbb439bd9b921095da657a4de906510d2cd'

        result =3D self.client.report_unihash(taskhash, self.METHOD, outh=
ash, unihash)
        self.assertEqual(result['unihash'], unihash, 'Server returned bad=
 unihash')

        # Check the hash via the read-only server
        self.assertClientGetHash(ro_client, taskhash, unihash)

        # Ensure that reporting via the read-only server returns actual u=
nihash without modifying the database
        taskhash2 =3D 'c665584ee6817aa99edfc77a44dd853828279370'

        result =3D ro_client.report_unihash(taskhash2, self.METHOD, outha=
sh, taskhash2)
        self.assertEqual(result['unihash'], unihash)

        # Ensure that the database was not modified
        self.assertClientGetHash(self.client, taskhash2, None)


By the way, how come I'm not mentioned in your proposed patch fix??

---
--=20
2.25.1

Karim Ben Houcine

