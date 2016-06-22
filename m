Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D2572600B3;
	Wed, 22 Jun 2016 21:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5MLZp2w023193; Wed, 22 Jun 2016 22:35:51 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id NCqjgoGHRw6M; Wed, 22 Jun 2016 22:35:51 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5MLZohR023189
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Jun 2016 22:35:51 +0100
Message-ID: <1466631350.3319.200.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>,
	openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 22 Jun 2016 22:35:50 +0100
In-Reply-To: <20160622155839.GC4153@jama>
References: <20160615073901.27831.65435@opal.openembedded.org>
	<20160622155839.GC4153@jama>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: openembedded-commits@lists.openembedded.org
Subject: Re: Bitbake output format changed Was: [oe-commits] [bitbake] branch master updated (a3f464d -> 0219271)
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
X-List-Received-Date: Wed, 22 Jun 2016 21:35:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-06-22 at 17:58 +0200, Martin Jansa wrote:
> On Wed, Jun 15, 2016 at 07:39:01AM +0000, git@git.openembedded.org wr
> ote:
> > rpurdie pushed a change to branch master
> > in repository bitbake.
> > 
> >       adds  2c88afb   taskdata/runqueue: Rewrite without use of ID
> > indirection
> 
> Is it expected that this change also changes the format of summary 
> shown at the end of the build and failed tasks.
> 
> The commit message doesn't mention this (it even says:
> ..
> On the most part there shouldn't be user visible changes.
> ..
> There should be no functionality changes in this patch, its purely a
> data structure change and that is visible in the patch.
> ..
> )
> 
> So before I start fixing scripts (e.g. test-dependencies) which are 
> trying to parse bitbake output to work with new format, please 
> confirm that this was intentional and that it will stay this way.
> 
> It's also not clear why the task is mentioned twice, e.g. as:
>   NOTE: Running task 512 of 548 (ID: /OE/build/oe-core/openembedded
> -core/meta/recipes-devtools/rpm/sftp.bb:do_fetch, /OE/build/oe
> -core/openembedded-core/meta/recipes-devtools/rpm/sftp.bb:do_fetch)
>   ERROR: Task /OE/build/oe-core/openembedded-core/meta/recipes
> -devtools/rpm/sftp.bb:do_fetch (/OE/build/oe-core/openembedded
> -core/meta/recipes-devtools/rpm/sftp.bb:do_fetch) failed with exit
> code '1'
> 
> are there cases where these 2 are different? and can both messages
> use the same "format" for task description?

The taskids are no more, there is simply no notion of them inside
bitbake any longer. That means that yes, we probably do need to change
the output a bit since the number doesn't mean anything.

Equally, it shouldn't be showing the same thing twice, that is a bug.
Internally to bitbake, everthing is now in the form (or will be when
multiconfig lands) "[multiconfig:<configname>:]<recipe
filename>:<taskname>". The question is whether we expose that to the
user or massage it at all. I'm tempted just to expose that string to
the user.

Sorry about the script changes, not sure we can avoid it though :( The
code is *way* easier to understand, debug and extend after these
changes FWIW so I do believe it very worth doing.

Cheers,

Richard


