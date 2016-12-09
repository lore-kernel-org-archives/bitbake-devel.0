Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id AC1A16013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:01 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id t79so32670996wmt.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=OwdefM6H6wjLaCLPkVzrtgDSeXNtwvPh1tIvwZohN0M=;
	b=cGGVptIkjpXAMRABRR3ZE6i0eUx4yWOMvNPkymwTZID4ePwcj9DS6lnx0roqTcA6QB
	1AnYxRSOSCQ+Lb9+HsNi2T9jtYAEsxLYSDTJ0HjumCpHnNZNgGiou080oxC91C2cQQfb
	Xc5fQiaCY2pDdDbfZwspn18C2YlWTNcT4qQADFNo/Ad3j/168Q7NlsdixdVvnzColwXZ
	q+A09MYdnbQdIMm5yuLFnfj0GRsmE1/p8qboku1V9vuiIjZ9brPyzr0YDPTwhByA5a5R
	nB0TiR++ohAhDffZE8WUHOpvuKrb70QXFzsi073MUq8ejdFzdaOm4QsEmcFmClY/PFgN
	arxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=OwdefM6H6wjLaCLPkVzrtgDSeXNtwvPh1tIvwZohN0M=;
	b=FGXJPLrQQCtD9/gtUW6mKPlhn5zOfdBRONUvzeux4h6JaW7AdSdg5hNp9aeGuuFsRV
	eVpfGru5JrHjQn+pHtAuGJLLCbgQZ5vK39uDuqP5jbAjtyTHOzPXPMMWP9LxuOuCshsf
	fgXamn1aY/MDIXFSxcjeB0YWHfvm5LaJ+1XrG5s9jEBDn8RtcW6bpgo/Ddk4EjCEIa9X
	uu7bJLCUI8erUmD6/gem8eEWOtgQxgL5bvaz1vEqaEIuYRWQ4CXxjHc2PvKeVUEEvSJp
	3sLAUJh7YogHc/e3ayjSi2/L5gxZFNDLcavV1TUb+N6kmbcDrar7I2lli5dBqxA308nb
	Mm8g==
X-Gm-Message-State: AKaTC02WzBa/EdPe2MQ4G8jxDjzwuM7gE20io0+lOHrtyjZCtJOuA3HmxTuIVxwc45VItoWc
X-Received: by 10.28.216.9 with SMTP id p9mr7425559wmg.11.1481302382989;
	Fri, 09 Dec 2016 08:53:02 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:02 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:41 +0000
Message-Id: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 00/14] Patches for Toaster 09.12.16
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:02 -0000

This is the latest patchset for submission upstream from Toaster mailing list.
These are all the patches pending integration 23.11.16 to 09.12.16

See toaster mailing list for more details.

Michael Wood (14):
  toaster: tablejs Add visual indicator for table data loading
  toaster: models Layer fix whitespace
  toaster: models Layer_Version get_detailspage_url optional project_id
  toaster: api Add layer Add api
  toaster: importlayer Use new layer add API
  toaster: tests Update import layer test to use new Layer add api
  toaster: typeaheads widgets Fix flake8 issues and remove redundant
    code
  toaster: typeaheads Add a git revisions suggestions
  toaster: importlayer Add git revision typeahead to that input field
  toaster: api Add GET REST API for Layer information
  toaster: typeaheads Layers add url to layer REST API to the layer
  toaster: Switch front end to use Layer get REST API
  toaster: js test Update js tests to use correct url for layer REST
  toaster: views Remove old code that converts template context to JSON

 lib/toaster/orm/models.py                          |  10 +-
 lib/toaster/tests/views/test_views.py              |  45 ++++---
 lib/toaster/toastergui/api.py                      | 150 ++++++++++++++++++++-
 lib/toaster/toastergui/static/css/default.css      |   1 -
 lib/toaster/toastergui/static/js/importlayer.js    |  36 +++--
 lib/toaster/toastergui/static/js/libtoaster.js     |   6 +-
 lib/toaster/toastergui/static/js/table.js          |  10 ++
 lib/toaster/toastergui/static/js/tests/test.js     |   8 +-
 lib/toaster/toastergui/templates/importlayer.html  |   7 +-
 lib/toaster/toastergui/templates/layer_btn.html    |  15 ++-
 lib/toaster/toastergui/templates/layerdetails.html |   1 +
 lib/toaster/toastergui/templates/machine_btn.html  |   7 +-
 lib/toaster/toastergui/templates/recipe_btn.html   |   8 +-
 lib/toaster/toastergui/typeaheads.py               | 112 +++++++++------
 lib/toaster/toastergui/urls.py                     |  11 +-
 lib/toaster/toastergui/views.py                    | 148 +-------------------
 lib/toaster/toastergui/widgets.py                  |   8 +-
 17 files changed, 343 insertions(+), 240 deletions(-)

-- 
2.7.4


