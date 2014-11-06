Return-Path: <s.mueller-klieser@phytec.de>
Received: from root.phytec.de (mail.phycard.de [217.6.246.34])
	by mail.openembedded.org (Postfix) with ESMTP id 53E06720A1
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Nov 2014 12:14:39 +0000 (UTC)
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id E15EFA00263
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Nov 2014 13:05:07 +0100 (CET)
Received: from lws-mklieser.phytec.de ([172.16.10.21])
	by idefix.phytec.de (Lotus Domino Release 8.5.3FP6)
	with ESMTP id 2014110613045786-48248 ;
	Thu, 6 Nov 2014 13:04:57 +0100 
From: =?UTF-8?q?Stefan=20M=C3=BCller-Klieser?= <s.mueller-klieser@phytec.de>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 6 Nov 2014 13:03:37 +0100
Message-Id: <1415275418-8007-1-git-send-email-s.mueller-klieser@phytec.de>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 8.5.3FP6|November
	21, 2013) at 06.11.2014 13:04:58,
	Serialize by Router on Idefix/Phytec(Release 8.5.3FP6|November 21,
	2013) at 06.11.2014 13:04:58
Subject: [PATCH 0/1] data_smart.py
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
X-List-Received-Date: Thu, 06 Nov 2014 12:14:44 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear list,

this is a small fix for the =5Fremove machanism. Does it propagate into Pok=
y if I post it here?

Regards, Stefan

Stefan M=C3=BCller-Klieser (1):
  data=5Fsmart.py: fix variable splitting at =5Fremove mechanism

 lib/bb/data=5Fsmart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
1.9.1


