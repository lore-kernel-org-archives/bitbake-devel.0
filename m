Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1ULIF1-0005Pi-Ue
	for bitbake-devel@lists.openembedded.org;
	Thu, 28 Mar 2013 20:12:05 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 28 Mar 2013 11:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,367,1363158000"; d="scan'208";a="309912024"
Received: from unknown (HELO helios.localnet) ([10.255.13.158])
	by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2013 11:54:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Andrei Dinu <andrei.adrianx.dinu@intel.com>
Date: Thu, 28 Mar 2013 18:54:58 +0000
Message-ID: <3315515.WXWKcWa1L2@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.1 (Linux/3.5.0-26-generic; KDE/4.10.1; i686; ; )
In-Reply-To: <1364459002-4165-4-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1364459002-4165-1-git-send-email-andrei.adrianx.dinu@intel.com>
	<1364459002-4165-4-git-send-email-andrei.adrianx.dinu@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/6] packageinfo.bbclass : extended functionality
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
X-List-Received-Date: Thu, 28 Mar 2013 19:12:06 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andrei,

On Thursday 28 March 2013 10:23:19 Andrei Dinu wrote:
> Extended the functionality of packageinfo.bbclass
> so that the sistem retrieves information about the
> files brought in by each package. This is done
> (without activating buildhistory) by parsing
> the packages-split directory for each package.
> 
> Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
> ---
>  meta/classes/packageinfo.bbclass |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/meta/classes/packageinfo.bbclass
> b/meta/classes/packageinfo.bbclass index bd7b249..5e6f590 100644
> --- a/meta/classes/packageinfo.bbclass
> +++ b/meta/classes/packageinfo.bbclass
> @@ -8,6 +8,25 @@ python packageinfo_handler () {
>          package_archs = e.data.getVar('PACKAGE_ARCHS', True)
>          packaging = e.data.getVar('PACKAGE_CLASSES',
> True).split()[0].split('_')[1] deploy_dir = e.data.getVar('DEPLOY_DIR',
> True) + '/' + packaging +        dirs = os.listdir(tmpdir + '/work/')
> +        pkgsplit_dir = tmpdir + '/work/'
> +        items = {}
> +        passing = ''
> +        for directories in dirs:
> +                temp_dirs = os.listdir(pkgsplit_dir + directories)
> +                for temps1 in temp_dirs:
> +                        if os.path.exists(pkgsplit_dir + directories + '/'
> + temps1 + '/' + os.listdir(pkgsplit_dir + directories + '/' + temps1)[0] +
> '/packages-split'): +                                subs = pkgsplit_dir +
> directories + '/' + temps1 + '/' + os.listdir(pkgsplit_dir + directories +
> '/' + temps1)[0] + '/packages-split' +                                for
> temps in os.listdir(subs):
> +                                        items[temps] = {}
> +                                        for path, dirs, files in
> os.walk(pkgsplit_dir + directories + '/' + temps1 + '/' +
> os.listdir(pkgsplit_dir + directories + '/' + temps1)[0] +
> '/packages-split' + '/' + temps): +                                        
>                file_list = [] +                                            
>            if os.listdir(path) != []: +                                    
>                            items[temps][path] = [] +                       
>                                         for f in files: +                  
>                                                      file_list.append(f) + 
>                                                              
> items[temps][path].append(file_list) +
>          for arch in package_archs.split():
>              pkgdata_dir = tmpdir + '/pkgdata/' + arch + target_vendor + '-'
> + target_os + '/runtime/' if os.path.exists(pkgdata_dir):
> @@ -19,6 +38,8 @@ python packageinfo_handler () {
>                              try:
>                                  sdata =
> oe.packagedata.read_pkgdatafile(pkgdatafile) sdata['PKG'] = pkgname
> +                                if pkgname in items:
> +                                        sdata['FILES_INFO'] =
> items[pkgname] pkginfolist.append(sdata)
>                              except Exception as e:
>                                  bb.warn("Failed to read pkgdata file %s:
> %s: %s" % (pkgdatafile, e.__class__, str(e)))

This is a change against the metadata rather than BitBake; it needs to be sent 
separately to the OE-Core mailing list.

Before you send it there however, you really need to be using the PKGDEST 
variable instead of composing the path to packages-split using hardcoded path 
components.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


