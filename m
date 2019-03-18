Return-Path: <prvs=973ddaea1=Stefan.Klug@baslerweb.com>
Received: from mail01.baslerweb.com (mail01.baslerweb.com [80.156.24.166])
	by mail.openembedded.org (Postfix) with ESMTP id 766A67C6B5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Mar 2019 14:08:31 +0000 (UTC)
Received: from unknown (HELO ahr206s.basler.corp) ([172.16.20.206])
	by mail01-out.baslerweb.com with ESMTP; 18 Mar 2019 14:58:33 +0100
From: Stefan Klug <stefan.klug@baslerweb.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 18 Mar 2019 14:58:17 +0100
Message-ID: <20190318135820.7344-1-stefan.klug@baslerweb.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Originating-IP: [172.16.85.155]
X-ClientProxiedBy: ahr206s.basler.corp (172.16.20.206) To ahr206s.basler.corp
	(172.16.20.206)
X-C2ProcessedOrg: edc209ba-7b98-423a-8e4d-b8fa22bc0743
Subject: [PATCH 0/3] Fix some bitbake authentication issues
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
X-List-Received-Date: Mon, 18 Mar 2019 14:08:31 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

while using bitbake in our corporate environment I stumbled over some=20
authentication/stability issues.
This is my first patchset to this list. So please correct me if I
missed anything.

Regards Stefan

Stefan Klug (3):
  fetch2: Fix fetching of git repositories with kerberos authentication
  fetch2: Gracefully handle corrupt download-cache tarballs
  fetch2/wget: Fix authentication in checkstatus() of the wget fetcher

 lib/bb/fetch2/__init__.py | 1 +
 lib/bb/fetch2/git.py      | 7 +++++--
 lib/bb/fetch2/wget.py     | 4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

--=20



