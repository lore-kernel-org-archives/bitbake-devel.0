Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BADE9770E7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 13:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9GDI2OL008710; Fri, 16 Oct 2015 14:18:02 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PjCkLgRz0Shc; Fri, 16 Oct 2015 14:18:02 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9GDHlRv008655
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 16 Oct 2015 14:17:58 +0100
Message-ID: <1445001467.17974.18.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ed Bartosh <ed.bartosh@linux.intel.com>
Date: Fri, 16 Oct 2015 14:17:47 +0100
In-Reply-To: <355ebfff2a5145d117aa8122cb7efdf6917eeeeb.1444910218.git.ed.bartosh@linux.intel.com>
References: <cover.1444910218.git.ed.bartosh@linux.intel.com>
	<355ebfff2a5145d117aa8122cb7efdf6917eeeeb.1444910218.git.ed.bartosh@linux.intel.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] toaster: Add tests for error message display on the build dashboard
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
X-List-Received-Date: Fri, 16 Oct 2015 13:18:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-10-15 at 15:45 +0300, Ed Bartosh wrote:
> From: Elliot Smith <elliot.smith@intel.com>
> 
> Add tests to ensure that log messages with CRITICAL level and
> with EXCEPTION level are shown in the main errors display
> on the build dashboard.
> 
> [YOCTO #8320]
> 
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> ---
>  lib/toaster/toastergui/tests.py | 91 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
> index 7c4bd39..29dd7fd 100644
> --- a/lib/toaster/toastergui/tests.py
> +++ b/lib/toaster/toastergui/tests.py
> @@ -26,15 +26,15 @@ from django.test.client import RequestFactory
>  from django.core.urlresolvers import reverse
>  from django.utils import timezone
>  
> -from orm.models import Project, Release, BitbakeVersion, Package
> +from orm.models import Project, Release, BitbakeVersion, Package, LogMessage
>  from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer, Build
>  from orm.models import Layer_Version, Recipe, Machine, ProjectLayer, Target
>  from orm.models import CustomImageRecipe, ProjectVariable
>  from orm.models import Branch
>  
>  from toastergui.tables import SoftwareRecipesTable
> -from bs4 import BeautifulSoup
>  import json
> +from bs4 import BeautifulSoup
>  import re
 
Sadly this failed to apply to master, please send a version which
does...

Cheers,

Richard


