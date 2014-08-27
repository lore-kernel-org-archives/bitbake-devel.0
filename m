Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6484D65D56
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 11:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RBxno3028908; Wed, 27 Aug 2014 12:59:49 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MpwjIB81Zykk; Wed, 27 Aug 2014 12:59:49 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RBxjRX028904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 27 Aug 2014 12:59:46 +0100
Message-ID: <1409140786.5772.40.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
Date: Wed, 27 Aug 2014 12:59:46 +0100
In-Reply-To: <53FDB74E.8000600@digitalendoscopy.de>
References: <53FDB74E.8000600@digitalendoscopy.de>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: HG clone using subrepositories with username and password in url
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
X-List-Received-Date: Wed, 27 Aug 2014 11:59:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-08-27 at 12:47 +0200, Volker Vogelhuber wrote:
> In case one uses mercurial subrepositories, updating to a specific 
> revision may need an additional authentication for the subrepository. So 
> the attached patch adds the missing authentication parameters to the hg 
> update call.

Wasn't this merged back in April?

http://git.openembedded.org/bitbake/commit/lib/bb/fetch2/hg.py?id=dfa041c940caad12da50126a559afc8de089eeda

?

Cheers,

Richard




