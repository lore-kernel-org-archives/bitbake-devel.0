Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SfI06-0000mz-BK
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 23:54:46 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5ELi7HO025686
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jun 2012 14:44:07 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Thu, 14 Jun 2012 14:44:06 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Jun 2012 16:44:01 -0500
Message-ID: <1339710244-6755-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
MIME-Version: 1.0
Subject: [PATCH v2 0/3] fetch2: optimizations and pre-mirrors
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
X-List-Received-Date: Thu, 14 Jun 2012 21:54:46 -0000
Content-Type: text/plain

The first patch is a simple optimization to use a local clone if using
a file:// URL.  This cuts down the kernel fetch in some configurations
considerably.

The second two patches AIM to allow for the possibility of using a
local git archive that is not stored in a tar.gz file.  Richard was
kind enough to explain the the use cases around the uri_replace() such
that I could create a test case to show why the prior version of the
patch was completely wrong.

The uri_replace() can rewrite one git URL to another git URL should
have mirrors at your local site, and the prior patches had no
possibility to deal with this, because the git method was re-used.

Thanks,
Jason.


