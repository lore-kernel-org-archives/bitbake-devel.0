Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TS2PB-00068E-Gd for bitbake-devel@lists.openembedded.org;
	Sat, 27 Oct 2012 11:10:09 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9R8uaxF005922;
	Sat, 27 Oct 2012 09:56:36 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05673-01; Sat, 27 Oct 2012 09:56:31 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9R8uU0k005915
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 27 Oct 2012 09:56:31 +0100
Message-ID: <1351328189.22340.215.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Sat, 27 Oct 2012 09:56:29 +0100
In-Reply-To: <1351161383-17278-1-git-send-email-cristiana.voicu@intel.com>
References: <1351161383-17278-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: add a progress indicator when you select 'view log'
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
X-List-Received-Date: Sat, 27 Oct 2012 09:10:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-10-25 at 13:36 +0300, Cristiana Voicu wrote:
> - created a new file named "hobthreads.py", defining a thread
> for opening the log file in a subprocess using subprocess module;
> in the future I think we will add some other threads here, to
> implement some other performance issues
> - on "builddetailspage", "packageselectionpage" and "imagedetailspage"
> I have changed the manner for opening the log file; it uses the thread
> to open the file, and on main thread it creates a dialog to show a
> progress bar, which pulses till the file is open
> - this was added because when the log file is big, it takes time to
> be opened; on the dialog you can use "Cancel" button to terminate the
> process initiated to open the file
> 
> [YOCTO #2997]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>

Merged to master, thanks.

Richard



