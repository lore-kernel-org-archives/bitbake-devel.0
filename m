Return-Path: <andrej.valek@siemens.com>
X-Greylist: delayed 453 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 01 Feb 2018 15:54:35 UTC
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
	by mail.openembedded.org (Postfix) with ESMTP id CB03E786D2
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Feb 2018 15:54:35 +0000 (UTC)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w11FsZMR013818
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 1 Feb 2018 16:54:35 +0100
Received: from [192.168.253.100] (sk1d124c.siemens.sk [163.242.57.217])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTPS id w11FsYNc025878
	(version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 1 Feb 2018 16:54:35 +0100
To: bitbake-devel@lists.openembedded.org
From: Andrej Valek <andrej.valek@siemens.com>
Message-ID: <a1ac7309-f1b9-6788-2973-4115f8283911@siemens.com>
Date: Thu, 1 Feb 2018 16:54:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.2
MIME-Version: 1.0
Subject: http AUTOREV feature
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
X-List-Received-Date: Thu, 01 Feb 2018 15:54:36 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi all,

I would like to ask You a question about AUTOREV feature request.

I would like to have the same AUTOREV feature for http/s, ftp file
downloading like in git/svn. This feature will download new files even
if a recipe wasn't changed.

I have made some tests in bbclass, how could be working.

for uri in d.getVar('SRC_URI', True).split():
   (scheme, _ , path) = bb.fetch.decodeurl(uri)[:3]

   if scheme in ("http", "https", "ftp"):
   # get remote file timestamp
      try:
         resp = urlopen(uri, timeout=5)
         timestamp = resp.info().getheaders("Last-Modified")[0]
      except Exception as e:
         bb.warn("Error gettig timestamp for %s (%s)" % (uri, e))

This stuff just downloads header data (not the whole file). From the
header parses last modification timestamp. This timestamp will be
converted into md5sum and appended set into AUTOREV variable like
"+httpXXXXX".

What do you think about it? Would be this kind of feature acceptable?

Regards,
Andrej

