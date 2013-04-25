Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1UVOrr-0004F7-AD
	for bitbake-devel@lists.openembedded.org;
	Thu, 25 Apr 2013 18:17:58 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r3PG0Art028514
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Apr 2013 09:00:10 -0700 (PDT)
Received: from msp-dhcp5.wrs.com (172.25.34.5) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.342.3;
	Thu, 25 Apr 2013 09:00:10 -0700
Message-ID: <5179530A.3000202@windriver.com>
Date: Thu, 25 Apr 2013 11:00:10 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8;
	rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <6C486AB80682E24095E3E77A408D68F252A4D7F1@ALA-MBA.corp.ad.wrs.com>
In-Reply-To: <6C486AB80682E24095E3E77A408D68F252A4D7F1@ALA-MBA.corp.ad.wrs.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	r3PG0Art028514
Subject: Re: Question about the setVar method
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
X-List-Received-Date: Thu, 25 Apr 2013 16:18:09 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 4/25/13 8:08 AM, Kuhl, Brian wrote:
> I=92m working on a new bitbake class which includes the following funct=
ion which
> works as desired except the
>
> d.setVar( dict[cmd],retlist[0])
>
> function does not appear to have global scope, and its effects are not =
seen
> outside the function.
>
> How do I give this operation global scope?

Only things that run during variable loading time will get a global scope=
.  For=20
python functions this would be the:

python() { ... }

python __anonymous() { ... }

or I believe events.  But each of these need to happen before the recipe=20
building has begun.  Once the recipes are in progress, the scope becomes =
local.=20
  If you need to share information between local scopes, then you will ha=
ve to=20
write out a file with the information and load it in each of the "user"=20
instances.  The users will have to have a dependency on the provider.

> python rpm_spec_do_postpatch() {
>
>                 import subprocess
>
>                 dict =3D {'DESCRIPTION':'DESCRIPTION',
>
>                                               'LICENSE':'LICENSE',
>
>                                               'SUMMARY':'SUMMARY',
>
>                                               'URL':'HOMEPAGE' }
>
>                 harvest_spec =3D d.getVar('HARVEST_SPEC', True)
>
>                 if harvest_spec :
>
>                                pn =3D d.getVar('PN', True)
>
>                                workdir =3D d.getVar('WORKDIR', True)
>
>                                src_spec =3D d.getVar('SRCSPEC', True)
>
>                                rpm_args =3D d.getVar('RPM_ARGS',True)
>
>                                spec_path =3D os.path.join( workdir,src_=
spec )
>
>                                prefix =3D "rpm -q %s --specfile %s --qf=
 '%%{" %
> (rpm_args,spec_path)
>
>                                postfix =3D "}<:>' "
>
>                                for cmd in dict:
>
>                                               cmd_str =3D prefix + cmd =
+ postfix
>
>                                               retstr =3D
> subprocess.check_output(cmd_str, shell=3DTrue)
>
>                                               retlist =3D retstr.split(=
'<:>')
>
>                                               if retlist[0]:
>
>                                                              d.setVar(
> dict[cmd],retlist[0])
>
>                                                              bb.data.up=
date_data(d)
>
>                                                              bb.note
> ("rpm_spec_do_postpatch HARVEST_SPEC setting  %s in %s to: %s \n" %(
> (dict[cmd]),pn,retlist[0]))
>
> }
>
> Brian Kuhl
>
> Wind River
>
> kuhlenough @ skype
>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>



