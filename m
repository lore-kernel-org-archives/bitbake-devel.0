Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 795FD77002
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Oct 2015 10:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t95AFXGZ010489; Mon, 5 Oct 2015 11:15:51 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DSf7Xcs2shw3; Mon,  5 Oct 2015 11:15:51 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t95AFSDH010425
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 5 Oct 2015 11:15:45 +0100
Message-ID: <1444032447.5118.2.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANkWo=s5VDpO0nAs42q8Cv+sfhNeu7qsv+XBckEQFQZy7Q@mail.gmail.com>
References: <1443445902-32608-1-git-send-email-liu.ming50@gmail.com>
	<CABcZANkWo=s5VDpO0nAs42q8Cv+sfhNeu7qsv+XBckEQFQZy7Q@mail.gmail.com>
Date: Mon, 05 Oct 2015 09:07:27 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.12.11-0ubuntu3 
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Peter Liu <peter.x.liu@external.atlascopco.com>,
	Ming Liu <liu.ming50@gmail.com>
Subject: Re: [OE-core] [PATCH] bitbake: fetch: Extend subdir unpack parameter to local folder
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
X-List-Received-Date: Mon, 05 Oct 2015 10:15:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2015-10-03 at 11:35 -0700, Christopher Larson wrote:
> 
> On Mon, Sep 28, 2015 at 6:11 AM, Ming Liu <liu.ming50@gmail.com>
> wrote:
>         +                    if urldata.parm.get('subdir') != None:
>         +                        destdir = urldata.parm.get('subdir')
>         + "/" + destdir
> 
> If you really care about the difference between None and the empty
> string, then this should be 'is not None', not '!= None', but most
> likely you don't, in which case 'if urldata.parm.get('subdir')' is
> sufficient, and cleaner. Also you do the parm.get() twice, it may be
> better to store that in a variable.

Chris is correct, this patch needs tweaking. This area of the code also
keeps seeing various issues so I'd like to ask that we add a test case
for this in lib/bb/tests/ so we can ensure this doesn't regress in the
future please.

Cheers,

Richard



