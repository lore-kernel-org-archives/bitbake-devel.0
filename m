Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>)
	id 1QQ493-00075Q-4j; Fri, 27 May 2011 23:00:33 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 27 May 2011 13:57:26 -0700
X-ExtLoop1: 1
Received: from vorpal.jf.intel.com (HELO [10.7.199.68]) ([10.7.199.68])
	by orsmga002.jf.intel.com with ESMTP; 27 May 2011 13:57:26 -0700
From: Joshua Lock <josh@linux.intel.com>
To: openembedded-core@lists.openembedded.org
Date: Fri, 27 May 2011 14:00:57 -0700
In-Reply-To: <1306526949.1747.8.camel@vorpal>
References: <cover.1306477652.git.lianhao.lu@intel.com>
	<1306515635.27470.284.camel@rex>
	<7DC6724C-BF20-4EA1-A87D-32FBEEECDA3B@dominion.thruhere.net>
	<1306526949.1747.8.camel@vorpal>
X-Mailer: Evolution 3.0.1 (3.0.1-1.fc15) 
Message-ID: <1306530057.1747.11.camel@vorpal>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] [PATCH 00/11] Add PR service and integrate PKGV/PKGR from OE
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
X-List-Received-Date: Fri, 27 May 2011 21:00:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-05-27 at 13:09 -0700, Joshua Lock wrote:
> Upstream BitBake still has the xmlrpc server removed. The version in
> Poky's BitBake is functional (I use it daily).
> 
> Attached are two patches against BitBake master to add back the xmlrpc
> server (copied from Poky's tree) and fix the uievent.

Something in the pipeline is eating patches.

I'll send them as replies to this message.

Joshua
-- 
Joshua Lock
        Yocto Project Build Monkey
        Intel Open Source Technology Centre



