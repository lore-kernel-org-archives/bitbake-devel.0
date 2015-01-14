Return-Path: <akuster808@gmail.com>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
	[209.85.192.174])
	by mail.openembedded.org (Postfix) with ESMTP id 47854721E2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jan 2015 18:04:51 +0000 (UTC)
Received: by mail-pd0-f174.google.com with SMTP id fp1so11101671pdb.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jan 2015 10:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=rnct6UVfTpyBk8ZYKjJzN/LpPTC1AaqMMvXqW9ElxO8=;
	b=dGdkrvE4DyS8MTibgxVzV+U4SESxomVIqe897zHsaLp36ctlp2gl9W22ix0ZRXBzC9
	Ly4ZgvUyoCIVQSqI1sFPYYmYx4agvFgm2dXtX+x9BoUNG58yifvt8H66pbVL3Q4FJJWF
	tFjFduyvBKGgydIrqjRdVbn7lv0ELd5dZDR+mVvkEiIHY62YQwncjrTSrldu9+VuGS2a
	CuGcAtu0dbX/AjG7dykZfknSyOIr77tjOBbfCqKYWMFi02MHWrrjw5N1uHg4JEyi1KvW
	hAOxo68w6negFLDor8jc3NltZIRdW3ehSFYAAUCNT9mdkFXlzH/0eg0JTmZIIyrXc9D9
	h1dw==
X-Received: by 10.70.89.174 with SMTP id bp14mr7572527pdb.136.1421258692657;
	Wed, 14 Jan 2015 10:04:52 -0800 (PST)
Received: from [10.43.100.29] (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
	by mx.google.com with ESMTPSA id
	ws4sm20234882pbc.53.2015.01.14.10.04.50
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 14 Jan 2015 10:04:51 -0800 (PST)
Message-ID: <54B6AFC2.30605@gmail.com>
Date: Wed, 14 Jan 2015 10:04:50 -0800
From: akuster808 <akuster808@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To: Alex DAMIAN <alexandru.damian@intel.com>, 
	bitbake-devel@lists.openembedded.org
References: <cover.1421239131.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421239131.git.alexandru.damian@intel.com>
Subject: Re: [PATCH 0/4] Toaster feature / bugfix patchset
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
X-List-Received-Date: Wed, 14 Jan 2015 18:05:02 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

are any of these needed for dizzy?

- armin

On 01/14/2015 04:46 AM, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
>
> This patchset brings in the layer details page, and the managed version
> of the "all builds" page.
>
> The patches have been reviewed on the Toaster mailing list.
>
> Can you please pull at your convenience ?
>
>
> Cheers,
> Alex
>
>
> The following changes since commit 0557d03c170fba8d7efe82be1b9641d0eb229213:
>
>    cooker/cache/parse: Implement pyinofity based reconfigure (2015-01-13 22:23:21 +0000)
>
> are available in the git repository at:
>
>    git://git.yoctoproject.org/poky-contrib adamian/20150114-submission-bb
>    http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150114-submission-bb
>
> Alexandru DAMIAN (2):
>    toastergui: all builds page lists failed build requests
>    toasterui: fix variable data error
>
> Michael Wood (2):
>    toaster: Add layer details page feature
>    toaster: layerdetails Remove compatibility setting
>
>   lib/bb/ui/buildinfohelper.py                       |   2 +-
>   lib/toaster/toastergui/static/css/default.css      |   1 +
>   lib/toaster/toastergui/static/js/layerdetails.js   | 398 ++++++++++++
>   lib/toaster/toastergui/static/js/libtoaster.js     |  35 +
>   lib/toaster/toastergui/templates/layerdetails.html | 625 +++++++++++++-----
>   .../toastergui/templates/layers_dep_modal.html     |   9 +
>   .../toastergui/templates/managed_builds.html       | 135 ++++
>   .../toastergui/templates/managed_mrb_section.html  | 172 +++++
>   lib/toaster/toastergui/templatetags/projecttags.py |  19 +
>   lib/toaster/toastergui/urls.py                     |   1 +
>   lib/toaster/toastergui/views.py                    | 708 +++++++++++++++------
>   11 files changed, 1755 insertions(+), 350 deletions(-)
>   create mode 100644 lib/toaster/toastergui/static/js/layerdetails.js
>   create mode 100644 lib/toaster/toastergui/templates/managed_builds.html
>   create mode 100644 lib/toaster/toastergui/templates/managed_mrb_section.html
>

