Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 2E8E373CBD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 02:43:53 +0000 (UTC)
Received: by padbj2 with SMTP id bj2so8697210pad.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Sep 2015 19:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=BR7Vwxlg3seFz4ZssT9DpEUUkE0kwBcsGBN5Ek5KqRQ=;
	b=mkiXlcJM3TOE7P83KEZT/tYzXN5Jogybk7q2yQYNMk4lzMSZ3Qo8E4as97PHBdOGuE
	nhzIz04D6trrS1W0sUajfAzR0vzgso4GQpsoQGiylFQnnn1f7aLciycFMnwRTgkGNJLI
	4P53c6L701toyEKISAtnizgECKoJB+Q2UV+laoKJjrmKLiAjsesK9AeCRTP6KpQKo9bO
	FAf0SACctcmBx5AOEgfKUcEaehy7t0b6PtVa+bu7b0w5G8gickq7efN93Psj4hlNDgA6
	44Abvlp7Wmm4Ol1T1GW6Xa31thtu0crLSRJqt5MRyTf6915DHueshljoG2sH2+BDEoXI
	RSfQ==
X-Received: by 10.66.216.1 with SMTP id om1mr28531994pac.51.1442889834260;
	Mon, 21 Sep 2015 19:43:54 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	iy1sm27116238pbb.85.2015.09.21.19.43.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 21 Sep 2015 19:43:53 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Sep 2015 19:45:19 -0700
Message-Id: <cover.1442889863.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/1] Fix back button tab behaviour
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
X-List-Received-Date: Tue, 22 Sep 2015 02:43:54 -0000

This completes the behaviour fix of the back button in the layerdetails
page as we not only have parameters in our history we also have the hash
to indicate which tab is active. As we pop our history we need to show
the corresponding tab.

The following changes since commit 7b86c771c80d0759c2ca0e57c46c4c966f89c49e:

  bitbake: bitbake: bb.fetch2.git: Import errno module (2015-09-19 22:38:44 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/michaelw/20150920_layerdetails_8252
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/michaelw/20150920_layerdetails_8252

Michael Wood (1):
  toaster: layerdetails Fix back button tab behaviour

 lib/toaster/toastergui/static/js/layerdetails.js | 28 +++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

-- 
1.9.1


