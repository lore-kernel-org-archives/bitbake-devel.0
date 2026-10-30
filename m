Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6895.1793349439250193081
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Oct 2026 01:37:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@emlix.com header.s=20250930 header.b=Gv2kY7mn;
 spf=pass (domain: emlix.com, ip: 178.63.209.131, mailfrom: andreas.muetzel@emlix.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
	s=20250930; t=1793349425;
	bh=1AgQnakmoUFV5xSbss5bojQww1+B+76kGEXWUWmVqtc=;
	h=From:To:Subject:Date:From;
	b=Gv2kY7mn8alBX8pywGozdWf6DEnLLizchPAFfm5YhQEr42wjnT0o0q4lXC9GujVLQ
	 QK6+FGhhwJ8mBmx11pTQTpei+/YkO5OBzJUZ3bqofEoMLgWBu/E4/FWUmhazln5mlI
	 wtE8wwSe+jtcszbRUj7AbfFbp0Hi52XD6caJrpmxn7xOcj8sWWqbu5Ydjkxd1+tm5c
	 zeqeCUtW1FR6jm3NeIKc+/U+4mAB6lvsiKl7b7Jtwxtn8mIacBgN5I+c70QTRgINpx
	 QJOb4UURitsYX7wuPhL5LL0oqPyXXsWfNQ3LHr584N6gFdqeSqcXPpo+E1L72L8Ug4
	 0tZYDMC9XqitA==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id B46005F864
	for <bitbake-devel@lists.openembedded.org>; Fri, 30 Oct 2026 09:37:05 +0100 (CET)
From: Andreas =?UTF-8?B?TcO8dHplbA==?= <andreas.muetzel@emlix.com>
To: bitbake-devel@lists.openembedded.org
Subject: dump-signatures: argument mismatch between bitbake doc and oe-core code
Date: Fri, 30 Oct 2026 09:37:05 +0100
Message-ID: <xOOtQA9cT-CHOwye467idg@emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Virus-Scanned: clamav-milter 1.4.3 at mx1.emlix.com
X-Virus-Status: Clean
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 30 Oct 2026 08:37:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20383

Hi all,

I just encountered an issue when trying to dump/lock sstate signatures in a=
=20
project:=20
bitbake-user-manual-intro.rst and the bitbake help text say that
"bitbake -S none <recipe>" should create the file locked-sigs.inc containin=
g=20
the SSTATE signatures of all tasks required for the recipe. But this silent=
ly=20
does nothing - the file is not created.

Since oe-core commit ad57c3cac2a8d3e60222e3cca0685f582dcea135, the actual c=
all=20
is "bitbake -S lockedsigs <recipe>".

Before sending a patch to update the bitbake documentation, I'd like to=20
confirm: This is a problem that should be fixed on the bitbake documentatio=
n=20
side and not in oe-core, right?
The call from oe-core makes much more sense to me, but I may be missing som=
e=20
kind of bigger picture here.

Best regards,
Andreas


=2D-=20
emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
Office M=C3=BCnchen: Am Knie 16, 81241 M=C3=BCnchen, Germany
http://www.emlix.com

emlix - your embedded Linux partner


