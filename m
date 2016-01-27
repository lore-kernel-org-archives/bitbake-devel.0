Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0DD56770E3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 14:04:01 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 27 Jan 2016 06:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,354,1449561600"; d="scan'208";a="642199376"
Received: from jlock-mobl1.gar.corp.intel.com ([10.252.15.3])
	by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2016 06:03:12 -0800
Message-ID: <1453903391.3557.42.camel@linux.intel.com>
From: Joshua G Lock <joshua.g.lock@linux.intel.com>
To: Mirela Rabulea <mirela.rabulea@nxp.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 27 Jan 2016 14:03:11 +0000
In-Reply-To: <AM4PR0401MB1778CA63CBE3FE654CB9EDC78FC30@AM4PR0401MB1778.eurprd04.prod.outlook.com>
References: <AM4PR0401MB1778CA63CBE3FE654CB9EDC78FC30@AM4PR0401MB1778.eurprd04.prod.outlook.com>
X-Mailer: Evolution 3.18.4 (3.18.4-1.fc23) 
Mime-Version: 1.0
Cc: "Roman, Alexandru CostinX" <alexandru.costinx.roman@intel.com>, "Voiculescu,
	BogdanX A" <bogdanx.a.voiculescu@intel.com>
Subject: Re: [PATCH] Fix bug 8940 - Alow Hob to run images on a custom simulator, other than qemu
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
X-List-Received-Date: Wed, 27 Jan 2016 14:04:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Mirela,

On Thu, 2016-01-21 at 15:52 +0000, Mirela Rabulea wrote:
> Hi,
> I have been told that Hob is deprecated and to be replaced by
> Toaster, still I have some changes already made on Hob, which I would
> like to push. Besides that, I understand that at this moment Toaster
> cannot run images at all, via a button push.
> I would be happy if these changes make it into YP 2.1, M2 or at least
> M3.

Thanks for taking the time to develop and submit this change.

Whilst Hob is not under active development I'm not aware of a timeline
for removing it from the repository, thus I'd welcome improvements and
bug fixes.

> The current behavior of Hob is that there is a "Run Image" button
> which becomes visible only for qemu images.
>  
> My suggested change is:
> - if an image is selected and it is , let the "Run image" button be
> named "Run qemu image"

I think you meant "and it is qemu-compatible,"?

> - if an image is selected and it is not qemu-compatible, let the same
> button show up with the name "Run custom image", and besides that, an
> option shows-up to allow the selection of the custom script (by
> default it points out to runqemu script) to be used for launching
> this custom image
>  
> Associated bug:
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=8940
>  
> Related bug (feaure request):
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=8959
>  
>  
> Thanks Belen, Bogdan and Alexandru for helping me on this.

On an initial look this change looks good, I have a couple of minor
comments on the UI:

FILE_CHOOSER_ACTION_SAVE seems wrong, I think this should use
FILE_CHOOSER_ACTION_OPEN as we only want to select existing files. 

See:
https://developer.gnome.org/pygtk/stable/gtk-constants.html#gtk-filecho
oser-action-constants

Also I think we'd probably want to use something other than "Open" to
confirm selection of the emulator, but that's more of a question for
Belen. Personally I think "Select" or "Choose" makes more sense.

When I ran Hob with your change I noticed the "Run script:" detail is
positioned vertically in the middle of its parent box, the other boxes
in the "Image details" page have their content at the top of the parent
box — could you change that?

When you submit your v2 could you send the patch directly, rather than
as an attachment. This allows us to perform any review in-line in an
email reply.

You can use either the scripts in the openembedded-core repository
(scripts/[create|send]-pull-request) or git send-email directly.

Furthermore as the patch, when ready, will be applied directly to the
bitbake repository it would be useful to improve the commit message in
line with the OpenEmbedded recommendations: 
http://www.openembedded.org/wiki/Commit_Patch_Message_Guidelines

Specifically could you:
* include some detail in the commit message,
perhaps use the reasoning above?
* move the bug ID to the bottom of the
commit message, above the signed-off-by. It should be formatted as:
[YOCTO #8940]
* Fix the typo in the one-line description "Alow" ->
"Allow"

Of course having written this I realise we don't have a good resource
for BitBake contribution guidelines I've filed a bug in the Yocto
Project bugzilla to ensure we develop some guidelines for contributing
to the BitBake repository: 
https://bugzilla.yoctoproject.org/show_bug.cgi?id=9007

Thanks again for submitting this patch, I look forward to seeing v2!

Regards,

Joshua


