Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 4F6986D7C2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2013 11:28:42 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAFBSUxZ007829; Fri, 15 Nov 2013 11:28:30 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nNBZju7dkEQq; Fri, 15 Nov 2013 11:28:30 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAFBSO9s007805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 15 Nov 2013 11:28:26 GMT
Message-ID: <1384514900.6460.146.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Fri, 15 Nov 2013 11:28:20 +0000
In-Reply-To: <1384437390-10392-1-git-send-email-alexandru.damian@intel.com>
References: <1384426381-7869-2-git-send-email-alexandru.damian@intel.com>
	<1384437390-10392-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] cooker, toaster: variable definition tracking
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
X-List-Received-Date: Fri, 15 Nov 2013 11:28:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-11-14 at 13:56 +0000, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> In order to track the file where a configuration
> variable was defined, this patch bring these changes:
> 
> * a new feature is defined in CookerFeatures, named
> BASEDATASTORE_TRACKING. When a UI requests BASEDATASTORE_TRACKING,
> the base variable definition are tracked when configuration
> is parsed.
> 
> * getAllKeysWithFlags now includes variable history in the
> data dump
> 
> * toaster_ui.py will record the operation, file path
> and line number where the variable was changes
> 
> * toaster Simple UI will display the file path
> and line number for Configuration page
> 
> There is a change in the models to accomodate the recording
> of variable change history.
> 
> [YOCTO #5227]
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  lib/bb/cooker.py                                   | 15 ++++++++++++---
>  lib/bb/cookerdata.py                               |  1 +
>  lib/bb/ui/buildinfohelper.py                       | 14 ++++++++++----
>  lib/bb/ui/toasterui.py                             |  2 +-
>  lib/toaster/bldviewer/templates/configuration.html |  6 ++++--
>  lib/toaster/orm/models.py                          |  6 +++++-
>  6 files changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 0580cd5..4c9067b 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -81,7 +81,7 @@ class SkippedPackage:
>  
> 
>  class CookerFeatures(object):
> -    _feature_list = [HOB_EXTRA_CACHES, SEND_DEPENDS_TREE] = range(2)
> +    _feature_list = [HOB_EXTRA_CACHES, SEND_DEPENDS_TREE, BASEDATASTORE_TRACKING] = range(3)
>  
>      def __init__(self):
>          self._features=set()
> @@ -177,6 +177,9 @@ class BBCooker:
>          self.data.disableTracking()
>  
>      def loadConfigurationData(self):
> +        if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
> +            self.enableDataTracking()
> +
>          self.initConfigurationData()
>          self.databuilder.parseBaseConfiguration()
>          self.data = self.databuilder.data
> @@ -189,6 +192,10 @@ class BBCooker:
>          bb.data.update_data(self.event_data)
>          bb.parse.init_parser(self.event_data)
>  
> +        if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
> +            self.disableDataTracking()
> +
> +
>      def modifyConfigurationVar(self, var, val, default_file, op):
>          if op == "append":
>              self.appendConfigurationVar(var, val, default_file)
> @@ -320,7 +327,6 @@ class BBCooker:
>          open(confpath, 'w').close()
>  
>      def parseConfiguration(self):
> -
>          # Set log file verbosity
>          verboselogs = bb.utils.to_boolean(self.data.getVar("BB_VERBOSE_LOGS", "0"))
>          if verboselogs:
> @@ -1175,7 +1181,10 @@ class BBCooker:
>              try:
>                  v = self.data.getVar(k, True)
>                  if not k.startswith("__") and not isinstance(v, bb.data_smart.DataSmart):
> -                    dump[k] = { 'v' : v }
> +                    dump[k] = {
> +    'v' : v ,
> +    'history' : self.data.varhistory.variable(k),
> +                    }
>                      for d in flaglist:
>                          dump[k][d] = self.data.getVarFlag(k, d)
>              except Exception as e:
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index e640ed0..1cc7bc2 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -127,6 +127,7 @@ class CookerConfiguration(object):
>          self.dump_signatures = False
>          self.dry_run = False
>          self.tracking = False
> +        self.server_only = False
>  
>          self.env = {}
>  

Patch looks ok in general but I think the above is leftover and
unneeded?

Cheers,

Richard


