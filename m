Received: from smtp3-g21.free.fr ([212.27.42.3])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eric@eukrea.com>) id 1SBtxh-0006yo-0i
	for bitbake-devel@lists.openembedded.org;
	Sun, 25 Mar 2012 22:22:49 +0200
Received: from eb-e6520 (unknown [82.233.81.124])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C5EEDA6273;
	Sun, 25 Mar 2012 22:13:47 +0200 (CEST)
Date: Sun, 25 Mar 2012 22:13:46 +0200
From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Message-ID: <20120325221346.0b452c4f@eb-e6520>
Organization: =?ISO-8859-1?B?RXVrculh?= Electromatique
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: HOB2 : run image disabled
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
X-List-Received-Date: Sun, 25 Mar 2012 20:22:49 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Dongxiao,

when the image is built (core-minimal for qemuarm machine) :
- if I click on runimage : it ask for selecting an image
- if I select and image (either ext3 or tar.bz2) the "run image" link
  is disabled.
is that behaviour expected ?

Thanks,
Eric


