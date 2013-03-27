Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UKoJy-0000pL-5W
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Mar 2013 12:15:12 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 27 Mar 2013 03:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,917,1355126400"; d="scan'208";a="219381786"
Received: from adinu-vostro-460.rb.intel.com (HELO [10.237.105.146])
	([10.237.105.146])
	by AZSMGA002.ch.intel.com with ESMTP; 27 Mar 2013 03:58:07 -0700
Message-ID: <5152D0F4.5050707@intel.com>
Date: Wed, 27 Mar 2013 12:59:00 +0200
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1364380074-16382-1-git-send-email-andrei.adrianx.dinu@intel.com>
In-Reply-To: <1364380074-16382-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: Re: [PATCH 0/6] Add file information to package information window
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
X-List-Received-Date: Wed, 27 Mar 2013 11:15:15 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please ignore this patchset.

Thanks,

Andrei Dinu

On 03/27/2013 12:27 PM, Andrei Dinu wrote:
> Listing the files that are brought into an image
> from each package.
>
> [HOB #3925]
>
> Andrei Dinu (6):
>    cache_extra.py : added package information
>    cooker.py : added variables related to cache_extra
>    packageinfo.bbclass : extended functionality
>    propertydialog.py : added 'Package files' functionality
>    hoblistmodel.py : passing the package information to hob
>    packageselectionpage.py : added information to hob
>
>   bitbake/lib/bb/cache_extra.py                    |    3 ++
>   bitbake/lib/bb/cooker.py                         |    2 +
>   bitbake/lib/bb/ui/crumbs/hig/propertydialog.py   |   59 +++++++++++++++++++++-
>   bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |    7 ++-
>   bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    3 +-
>   meta/classes/packageinfo.bbclass                 |   21 ++++++++
>   6 files changed, 91 insertions(+), 4 deletions(-)
>   mode change 100755 => 100644 bitbake/lib/bb/ui/crumbs/packageselectionpage.py
>



