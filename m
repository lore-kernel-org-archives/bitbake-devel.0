Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1Sf0hl-0006T1-3x
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 05:26:41 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5E3G4Wl009248
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jun 2012 20:16:04 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 13 Jun 2012 20:16:03 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 13 Jun 2012 22:15:58 -0500
Message-ID: <1339643761-23149-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
MIME-Version: 1.0
Subject: [PATCH 0/3] runqueue changes
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
X-List-Received-Date: Thu, 14 Jun 2012 03:26:41 -0000
Content-Type: text/plain

This series is now about the runqueue changes around
invalidating the set scene tasks properly.

It adds new bitbake flags for the purpose of
invalidating setscene tasks.



