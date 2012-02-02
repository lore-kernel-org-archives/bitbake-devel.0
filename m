Received: from mail-ww0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rep.dot.nop@gmail.com>) id 1Rss30-0004lI-Bv
	for bitbake-devel@lists.openembedded.org;
	Thu, 02 Feb 2012 09:29:38 +0100
Received: by wgbdr13 with SMTP id dr13so2003923wgb.24
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 02 Feb 2012 00:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=7dqQ4K0WqTZvFo5gYeV57E80/WcO3PWujBNhsleKzh0=;
	b=OdCLEkoGDDNJI/CecZS2VO/L2OV1CbbMYl/AvqnHkWoT8lREW1rGfSaSO2bWWpDXOI
	8yq2e17L1XTMYg15SeLR6o5DoHhBdQU4aMILl9qdySNt8TGDe7M6hI3nDRIs7nZ5k1wM
	WASJq6duVJAxDqHTy2TZMVj11NJNUpey0Vq0g=
Received: by 10.180.90.225 with SMTP id bz1mr16395654wib.5.1328170902701;
	Thu, 02 Feb 2012 00:21:42 -0800 (PST)
Received: from s42.loc (85-127-19-201.dynamic.xdsl-line.inode.at.
	[85.127.19.201])
	by mx.google.com with ESMTPS id d9sm50020784wiy.2.2012.02.02.00.21.41
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 02 Feb 2012 00:21:42 -0800 (PST)
Received: from cow by s42.loc with local (Exim 4.77)
	(envelope-from <rep.dot.nop@gmail.com>)
	id 1RsrvI-0003NJ-ME; Thu, 02 Feb 2012 09:21:40 +0100
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Feb 2012 09:21:15 +0100
Message-Id: <1328170876-12909-1-git-send-email-rep.dot.nop@gmail.com>
X-Mailer: git-send-email 1.7.8.3
Subject: [PATCH] Add missing module to installer
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 02 Feb 2012 08:29:38 -0000

Ok for me to push this one?

Bernhard Reutner-Fischer (1):
  setup.py: Install concurrent too

 setup.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

-- 
1.7.8.3



