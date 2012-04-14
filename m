Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SJ0HR-0008Hn-LW for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 12:32:33 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3EANAcX012942;
	Sat, 14 Apr 2012 11:23:10 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10599-09; Sat, 14 Apr 2012 11:23:06 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3EAMxbU012934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 14 Apr 2012 11:23:01 +0100
Message-ID: <1334398981.7309.98.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Sat, 14 Apr 2012 11:23:01 +0100
In-Reply-To: <cover.1334359238.git.josh@linux.intel.com>
References: <cover.1334359238.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/4] Replace HobNotebook with gtk.Notebook, comments invited
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
X-List-Received-Date: Sat, 14 Apr 2012 10:32:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-04-13 at 16:24 -0700, Joshua Lock wrote:
> *** This series prevents users of distros with old Gtk+ releases using Hob ***
> 
> This is a follow-on from my RFC of yesterday with a similar title. Sadly I 
> hadn't realised that one of the API calls I am using is not available in the
> version of gtk+ shipped with CentOS 6 (gtk.Notebook.set_action_widget).
> 
> This change will prevent CentOS 6 users from being able to use Hob.
> 
> I spent some time in Gtk+ internals trying to figure out if we can emulate the
> behaviour on older versions but the GtkNotebook widget internals were enhanced
> significantly to support the set_action_widget API.
> 
> I've submitted the change as an RFC regardless, it's ready to merge if we're
> willing to make the sacrifice.
> 
> The primary motivation for making this change, and making it so late in the
> cycle, is maintainability. The diffstat says it all - we're replacing an ~400LOC
> custom widget with a ~100LOC set of 3 widgets which subclass standard toolkit
> widgets.
> 
> An added benefit is that standard toolkit widgets generally integrate better
> into the users OS thanks to inheriting their standard theme.
> 
> Tested on: 
> Fedora 16 (x86_64) - PASS
> CentOS 6.2 (x86_64) - FAIL: Gtk+ version too old
> Ubuntu 10.04 (x86_64) - Fail: pygtk version too old
> Ubuntu 12.04 Beta (x86_64) - PASS
> 
> Per the final patch in the series the changes here require gtk+-2.20 or newer
> and pygtk 2.22 or newer.

Since we don't have a good external-python tarball solution in place
yet, I'm going to have to hold off these patches until after the current
release.

Cheers,

Richard



