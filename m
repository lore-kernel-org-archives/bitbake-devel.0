Received: from smtpfb2-g21.free.fr ([212.27.42.10])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eric@eukrea.com>) id 1SAgMB-0006wh-0P
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 12:39:03 +0100
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id C7F35D1AA3D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Mar 2012 12:22:25 +0100 (CET)
Received: from eb-e6520 (unknown [82.233.81.124])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 42C96A6233
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Mar 2012 12:22:20 +0100 (CET)
Date: Thu, 22 Mar 2012 12:22:19 +0100
From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20120322122219.0df320be@eb-e6520>
Organization: =?ISO-8859-1?B?RXVrculh?= Electromatique
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Subject: Hob : IndexError: list index out of range
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
X-List-Received-Date: Thu, 22 Mar 2012 11:39:03 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

while testing HOB, once the image appears to finish to build, got this error :

Traceback (most recent call last):
  File "/home/ebenard/openembedded-core/bitbake/lib/bb/ui/crumbs/builder.py", line 431, in handler_command_succeeded_cb
    self.switch_page(self.IMAGE_GENERATED)
  File "/home/ebenard/openembedded-core/bitbake/lib/bb/ui/crumbs/builder.py", line 339, in switch_page
    self.image_details_page.show_page(next_step)
  File "/home/ebenard/openembedded-core/bitbake/lib/bb/ui/crumbs/imagedetailspage.py", line 187, in show_page
    image_size = self._size_to_string(os.stat(os.path.join(image_addr, image_names[0])).st_size)
IndexError: list index out of range

Eric


