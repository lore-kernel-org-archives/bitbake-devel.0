Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id CD60A7715E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 14:46:31 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u8FEkU9w019051
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 07:46:31 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.234) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Thu, 15 Sep 2016 07:46:29 -0700
To: Joe Slater <jslater@windriver.com>, <bitbake-devel@lists.openembedded.org>
References: <1473874192-1358-1-git-send-email-jslater@windriver.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <d6e1a497-37b8-71df-59d2-5c9965aaaa66@windriver.com>
Date: Thu, 15 Sep 2016 09:46:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
	Gecko/20100101 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1473874192-1358-1-git-send-email-jslater@windriver.com>
Cc: joe.slater@windriver.com
Subject: Re: [bitbake][PATCH 1/1] cooker.py: add LAYERRECOMMENDS processing
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
X-List-Received-Date: Thu, 15 Sep 2016 14:46:32 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

We had discussed this change on the oe-architecture list.  There were no
objections to this functionality.  Since recommends are allowed to fail, really
the code is simple enough and just makes sure the dynamic priority processing
will work properly if LAYERRECOMMENDS is implemented.

(We are also working on an enhancement to the layer index to also support
recommends.)

--Mark

On 9/14/16 12:29 PM, Joe Slater wrote:
> Add recommended layers to collection_depends[] so that dynamic
> priority assignment will work for both depends and recommends.
> 
> Recommended layers do not cause an error or warning
> if they are not in the collection list, but debug messages
> are output for level 3 and above.
> 
> explode_dep_versions2 returns a dictionary, so we
> change the variable deplist to depDict.  The dictionary
> values are lists which are either empty or contain only one
> version specification.
> 
> Signed-off-by: Joe Slater <jslater@windriver.com>
> ---
>  lib/bb/cooker.py |   37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 0e78106..093ac70 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1147,6 +1147,8 @@ class BBCooker:
>              collection_list = collections.split()
>              min_prio = 0
>              for c in collection_list:
> +                bb.debug(1,'Processing %s in collection list' % (c))
> +
>                  # Get collection priority if defined explicitly
>                  priority = self.data.getVar("BBFILE_PRIORITY_%s" % c, True)
>                  if priority:
> @@ -1165,10 +1167,10 @@ class BBCooker:
>                  deps = self.data.getVar("LAYERDEPENDS_%s" % c, True)
>                  if deps:
>                      try:
> -                        deplist = bb.utils.explode_dep_versions2(deps)
> +                        depDict = bb.utils.explode_dep_versions2(deps)
>                      except bb.utils.VersionStringException as vse:
>                          bb.fatal('Error parsing LAYERDEPENDS_%s: %s' % (c, str(vse)))
> -                    for dep, oplist in list(deplist.items()):
> +                    for dep, oplist in list(depDict.items()):
>                          if dep in collection_list:
>                              for opstr in oplist:
>                                  layerver = self.data.getVar("LAYERVERSION_%s" % dep, True)
> @@ -1187,10 +1189,39 @@ class BBCooker:
>                          else:
>                              parselog.error("Layer '%s' depends on layer '%s', but this layer is not enabled in your configuration", c, dep)
>                              errors = True
> -                    collection_depends[c] = deplist.keys()
> +                    collection_depends[c] = list(depDict.keys())
>                  else:
>                      collection_depends[c] = []
>  
> +                # Check recommends and store information for priority calculation
> +                recs = self.data.getVar("LAYERRECOMMENDS_%s" % c, True)
> +                if recs:
> +                    try:
> +                        recDict = bb.utils.explode_dep_versions2(recs)
> +                    except bb.utils.VersionStringException as vse:
> +                        bb.fatal('Error parsing LAYERRECOMMENDS_%s: %s' % (c, str(vse)))
> +                    for rec, oplist in list(recDict.items()):
> +                        if rec in collection_list:
> +                            if oplist:
> +                                opstr = oplist[0]
> +                                layerver = self.data.getVar("LAYERVERSION_%s" % rec, True)
> +                                if layerver:
> +                                    (op, recver) = opstr.split()
> +                                    try:
> +                                        res = bb.utils.vercmp_string_op(layerver, recver, op)
> +                                    except bb.utils.VersionStringException as vse:
> +                                        bb.fatal('Error parsing LAYERRECOMMENDS_%s: %s' % (c, str(vse)))
> +                                    if not res:
> +                                        parselog.debug(3,"Layer '%s' recommends version %s of layer '%s', but version %s is currently enabled in your configuration. Check that you are using the correct matching versions/branches of these two layers.", c, opstr, rec, layerver)
> +                                        continue
> +                                else:
> +                                    parselog.debug(3,"Layer '%s' recommends version %s of layer '%s', which exists in your configuration but does not specify a version. Check that you are using the correct matching versions/branches of these two layers.", c, opstr, rec)
> +                                    continue
> +                            parselog.debug(3,"Layer '%s' recommends layer '%s', so we are adding it", c, rec)
> +                            collection_depends[c].append(rec)
> +                        else:
> +                            parselog.debug(3,"Layer '%s' recommends layer '%s', but this layer is not enabled in your configuration", c, rec)
> +
>              # Recursively work out collection priorities based on dependencies
>              def calc_layer_priority(collection):
>                  if not collection_priorities[collection]:
> 


