Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1ULX2j-0003TV-S1 for bitbake-devel@lists.openembedded.org;
	Fri, 29 Mar 2013 12:00:29 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2TAqbYE024158; Fri, 29 Mar 2013 10:52:59 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id a92upxcuW+ef; Fri, 29 Mar 2013 10:52:59 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2TAqsEQ024166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 29 Mar 2013 10:52:57 GMT
Message-ID: <1364553762.28471.182.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Fri, 29 Mar 2013 10:42:42 +0000
In-Reply-To: <3315515.WXWKcWa1L2@helios>
References: <1364459002-4165-1-git-send-email-andrei.adrianx.dinu@intel.com>
	<1364459002-4165-4-git-send-email-andrei.adrianx.dinu@intel.com>
	<3315515.WXWKcWa1L2@helios>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
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
X-List-Received-Date: Fri, 29 Mar 2013 11:00:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-03-28 at 18:54 +0000, Paul Eggleton wrote:
> Hi Andrei,
> 
> On Thursday 28 March 2013 10:23:19 Andrei Dinu wrote:
> > Extended the functionality of packageinfo.bbclass
> > so that the sistem retrieves information about the
> > files brought in by each package. This is done
> > (without activating buildhistory) by parsing
> > the packages-split directory for each package.
> > 
> > Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
> > ---
> >  meta/classes/packageinfo.bbclass |   21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/meta/classes/packageinfo.bbclass
> > b/meta/classes/packageinfo.bbclass index bd7b249..5e6f590 100644
> > --- a/meta/classes/packageinfo.bbclass
> > +++ b/meta/classes/packageinfo.bbclass
> > @@ -8,6 +8,25 @@ python packageinfo_handler () {
> >          package_archs = e.data.getVar('PACKAGE_ARCHS', True)
> >          packaging = e.data.getVar('PACKAGE_CLASSES',
> > True).split()[0].split('_')[1] deploy_dir = e.data.getVar('DEPLOY_DIR',
> > True) + '/' + packaging +        dirs = os.listdir(tmpdir + '/work/')
> > +        pkgsplit_dir = tmpdir + '/work/'
> > +        items = {}
> > +        passing = ''
> > +        for directories in dirs:
> > +                temp_dirs = os.listdir(pkgsplit_dir + directories)
> > +                for temps1 in temp_dirs:
> > +                        if os.path.exists(pkgsplit_dir + directories + '/'
> > + temps1 + '/' + os.listdir(pkgsplit_dir + directories + '/' + temps1)[0] +
> > '/packages-split'): +                                subs = pkgsplit_dir +
> > directories + '/' + temps1 + '/' + os.listdir(pkgsplit_dir + directories +
> > '/' + temps1)[0] + '/packages-split' +                                for
> > temps in os.listdir(subs):
> > +                                        items[temps] = {}
> > +                                        for path, dirs, files in
> > os.walk(pkgsplit_dir + directories + '/' + temps1 + '/' +
> > os.listdir(pkgsplit_dir + directories + '/' + temps1)[0] +
> > '/packages-split' + '/' + temps): +                                        
> >                file_list = [] +                                            
> >            if os.listdir(path) != []: +                                    
> >                            items[temps][path] = [] +                       
> >                                         for f in files: +                  
> >                                                      file_list.append(f) + 
> >                                                              
> > items[temps][path].append(file_list) +
> >          for arch in package_archs.split():
> >              pkgdata_dir = tmpdir + '/pkgdata/' + arch + target_vendor + '-'
> > + target_os + '/runtime/' if os.path.exists(pkgdata_dir):
> > @@ -19,6 +38,8 @@ python packageinfo_handler () {
> >                              try:
> >                                  sdata =
> > oe.packagedata.read_pkgdatafile(pkgdatafile) sdata['PKG'] = pkgname
> > +                                if pkgname in items:
> > +                                        sdata['FILES_INFO'] =
> > items[pkgname] pkginfolist.append(sdata)
> >                              except Exception as e:
> >                                  bb.warn("Failed to read pkgdata file %s:
> > %s: %s" % (pkgdatafile, e.__class__, str(e)))
> 
> This is a change against the metadata rather than BitBake; it needs to be sent 
> separately to the OE-Core mailing list.
> 
> Before you send it there however, you really need to be using the PKGDEST 
> variable instead of composing the path to packages-split using hardcoded path 
> components.

Sorry, I missed this feedback. Can you please send a follow up patch to
the OE-Core list addressing the PKGDEST issue.

Thanks,

Richard



