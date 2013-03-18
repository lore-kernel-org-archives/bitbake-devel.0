Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UHY8x-0006il-69
	for bitbake-devel@lists.openembedded.org;
	Mon, 18 Mar 2013 12:22:20 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 18 Mar 2013 04:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,863,1355126400"; 
	d="scan'208,217";a="272271623"
Received: from adinu-vostro-460.rb.intel.com (HELO [10.237.105.45])
	([10.237.105.45])
	by azsmga001.ch.intel.com with ESMTP; 18 Mar 2013 04:04:24 -0700
Message-ID: <5146F4E4.5040306@intel.com>
Date: Mon, 18 Mar 2013 13:05:08 +0200
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
In-Reply-To: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Forwarded-Message-Id: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 00/11] replace tooltips with property windows in HOB
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
X-List-Received-Date: Mon, 18 Mar 2013 11:22:21 -0000
Content-Type: multipart/alternative;
	boundary="------------080904090706080609000401"

--------------080904090706080609000401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ping!


-------- Original Message --------
Subject: 	[PATCH 00/11] replace tooltips with property windows in HOB
Date: 	Tue, 5 Mar 2013 17:36:20 +0200
From: 	Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: 	<bitbake-devel@lists.openembedded.org>
CC: 	Andrei Dinu <andrei.adrianx.dinu@intel.com>



[Enhancement 2248] - https://bugzilla.yoctoproject.org/show_bug.cgi?id=2248

Added property windows for recipe selection page, package selection page
and also replaced the tooltips information pages with dialogs.

Andrei Dinu (11):
   added extra variables to cache_extra.py
   extended cooker.py variables
   replaced the function that displayed tooltips
   added information for the information dialogs
   new class added for the property windows.
   added entries for information dialogs
   added information columns needed for prop dialogs
   added functionality for the information dialogs.
   added information so that it displays correctly
   added event for the "All packages" tab
   added events for the "Package Groups" "All recipes

  bitbake/lib/bb/cache_extra.py                      |    9 +
  bitbake/lib/bb/cooker.py                           |    9 +
  bitbake/lib/bb/ui/crumbs/builder.py                |   35 +-
  .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |   12 +-
  bitbake/lib/bb/ui/crumbs/hig/propertydialog.py     |  347 ++++++++++++++++++++
  .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |   14 +-
  bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |   23 +-
  bitbake/lib/bb/ui/crumbs/hobwidget.py              |   22 +-
  bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    3 +-
  bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   13 +-
  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |   22 +-
  11 files changed, 472 insertions(+), 37 deletions(-)
  create mode 100644 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py

-- 
1.7.9.5




--------------080904090706080609000401
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Ping!<br>
    <div class="moz-forward-container"><br>
      <br>
      -------- Original Message --------
      <table class="moz-email-headers-table" border="0" cellpadding="0"
        cellspacing="0">
        <tbody>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">Subject:
            </th>
            <td>[PATCH 00/11] replace tooltips with property windows in
              HOB</td>
          </tr>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">Date: </th>
            <td>Tue, 5 Mar 2013 17:36:20 +0200</td>
          </tr>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">From: </th>
            <td>Andrei Dinu <a class="moz-txt-link-rfc2396E" href="mailto:andrei.adrianx.dinu@intel.com">&lt;andrei.adrianx.dinu@intel.com&gt;</a></td>
          </tr>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">To: </th>
            <td><a class="moz-txt-link-rfc2396E" href="mailto:bitbake-devel@lists.openembedded.org">&lt;bitbake-devel@lists.openembedded.org&gt;</a></td>
          </tr>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">CC: </th>
            <td>Andrei Dinu <a class="moz-txt-link-rfc2396E" href="mailto:andrei.adrianx.dinu@intel.com">&lt;andrei.adrianx.dinu@intel.com&gt;</a></td>
          </tr>
        </tbody>
      </table>
      <br>
      <br>
      <pre>[Enhancement 2248] - <a class="moz-txt-link-freetext" href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=2248">https://bugzilla.yoctoproject.org/show_bug.cgi?id=2248</a>

Added property windows for recipe selection page, package selection page
and also replaced the tooltips information pages with dialogs.

Andrei Dinu (11):
  added extra variables to cache_extra.py
  extended cooker.py variables
  replaced the function that displayed tooltips
  added information for the information dialogs
  new class added for the property windows.
  added entries for information dialogs
  added information columns needed for prop dialogs
  added functionality for the information dialogs.
  added information so that it displays correctly
  added event for the "All packages" tab
  added events for the "Package Groups" "All recipes

 bitbake/lib/bb/cache_extra.py                      |    9 +
 bitbake/lib/bb/cooker.py                           |    9 +
 bitbake/lib/bb/ui/crumbs/builder.py                |   35 +-
 .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |   12 +-
 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py     |  347 ++++++++++++++++++++
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |   14 +-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |   23 +-
 bitbake/lib/bb/ui/crumbs/hobwidget.py              |   22 +-
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    3 +-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   13 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |   22 +-
 11 files changed, 472 insertions(+), 37 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py

-- 
1.7.9.5

</pre>
      <br>
    </div>
    <br>
  </body>
</html>

--------------080904090706080609000401--
