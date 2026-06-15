Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC3CD98E3
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 17:38:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.135397.1781545090105900910
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 10:38:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=PY0Lqxf2;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0626ff78a0=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFej751186413;
	Mon, 15 Jun 2026 17:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=/tPE5BZLY
	DAIkKl7tbNQKtYOerHvMClBKZNmuGm+hI8=; b=PY0Lqxf2CyhWd2VWGUUE+p4Qf
	6b3v+uKP6INX+hCMkBPcfcltVEzxYm5Q4BOK7q4ZNAKN4am1eQjEQcJ+ID8OczDh
	9XHKINgcF7MHdgjXfdfk/PRmGSF1wSzl/FKimLGeIs6333zm4qIkup3uJPCDSgqv
	mLYMH2S0FvJH7eqcUkDuvvLWgeHMXM8iiNmWXtwzEGLFFt91E49FKNw/WdBzXcGb
	z9A2k+YDAOOUwcBzLTfv0hizatP98fqStmVwJJ9gWtoK9aWxa+uvU8Thc3M99mJ6
	TjSonx/su25Lgi9dgmkxzb4iZUyN0F0EcfeQiWT0qaXiGOBFFPxb2dG34uUDw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ervkp38se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Jun 2026 17:38:08 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 15 Jun 2026 10:38:06 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 15 Jun 2026 10:38:06 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Subject: [PATCH v3 00/10] bitbake-setup JSON Schema: Fix linting errors
Date: Mon, 15 Jun 2026 10:37:42 -0700
Message-ID: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGc4MGoC/yXM0QqCQBCF4VeRuW5g3VKkV4kuZteTjpLFjoYgv
 rtbXX5wzr+RISmMrsVGCR81fU0Z51NBsZepA2ubTd752tVlxQ9dOegcZARb7PEUdoImtGUj/hI
 pH98JefWL3u5/2xIGxPlbon0/AENKW4x2AAAA
X-Change-ID: 20260615-fix-bitbake-schema-0ae8bd18a24c
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX7RJmaDrx4cQh
 FSUPBP0GvniDuoJferRa0s++LWXdegmOtL6TOg5LCRJ3jWPLJaedJ81Hqg6FwedzdiE0Y+FofgB
 MeNnLf3Ii0awyO6N5PXrvo3gh4Y23qDXuVvJsICCqZMvzu2BJfr7Bxq4cfccRQGWP0yusHHJIv6
 QIhJP0XWVC3hToE+4GGa4ERA7BVXG+8XPH91NxcWy4QLp78mBQ3Z+gJD92CTwb66W2boGq3T9Pw
 Uzw6uNCfcf4D8oGT4hMSP+qzvDme4pidsoM5niclFwe/odCaRkcAd6idMdHpfoTbkJ/JVWscWB1
 mTDBCqrWq6wT4H8lXzwyNvwsCLsDoGkDqHTciwLc8eo33/Lp2ztKqMajBhlss8DMtFar9MNLGDD
 InVd8N66frdKFr5uDiap06CZ8/r6IJxR4zYkbQNhaoMXriV43egwMNT5KWfSSZ5GFeksfj3w9yr
 Be3apmsAwCxDmGZaRwA==
X-Authority-Analysis: v=2.4 cv=BK+DalQG c=1 sm=1 tr=0 ts=6a303880 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=NEAV23lmAAAA:8
 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=iTjcBdDkjFE6-rxjVPEA:9 a=QEXdDO2ut3YA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX0xDs32M5AIF0
 FxjCV5JbCoOSPxsSK9WI3acHCz4q/B6cvy6TEnZYE+DqavIt3eRqqqfqmOpUmj0uZZmNlAMIOo1
 k7zJ+pR5objjECPrFiAHFrLzpUUA0wsTkD9gQDZMDMZwdygNe5+b
X-Proofpoint-GUID: Uu_4fmEaQxoOrUMbhOuIdh5ZaFcLHzJ6
X-Proofpoint-ORIG-GUID: Uu_4fmEaQxoOrUMbhOuIdh5ZaFcLHzJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150186
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19690

UPDATES v3:
* bitbake-setup.schema.json
  * Updated example to bitbake+openembedded-core with qemux86-64+nodistro
* layers.schema.json
  * Fixed typo in description
  * Fixed up the title and description
  * Put the version element at the end
  * Used the short form

UPDATES v2:
  The following updates were made to v2 of this series:
   * Include an additional patch fixing an existing typo
   * Update the examples property to wrap it in an array and
     add a required configuration element

This series fixes some linting errors in the JSON Schema.  Problems
were found using the https://github.com/sourcemeta/jsonschema tool.

Here are the steps used to install and use the tool to lint the schemas:

```
  python3 -m venv venv
  source venv/bin/activate
  pip install sourcemeta-jsonschema
```

```
jsonschema lint setup-schema/bitbake-setup.schema.json
jsonschema lint setup-schema/layers.schema.json
```

NOTE: The examples are annotations and are meant for humans reading the schema.
They do not typically get checked automatically by the JSON Schema validation
tools.  Use jq to extract the JSON object into its own file to check it
separately.

```
cd setup-schema

jq .examples[] bitbake-setup.schema.json  > bitbake-setup.schema-examples.json
jsonschema validate bitbake-setup.schema.json bitbake-setup.schema-examples.json

jq .examples[] layers.schema.json  > layers.schema-examples.conf.json
jsonschema validate layers.schema.json layers.schema-examples.conf.json
cd ..

bitbake/bin/bitbake-setup init bitbake/setup-schema/bitbake-setup.schema-examples.conf.json

```

```
jsonschema validate setup-schema/bitbake-setup.schema.json default-registry/configurations/oe-nodistro-master.conf.json
jsonschema validate setup-schema/bitbake-setup.schema.json default-registry/configurations/oe-nodistro-whinlatter.conf.json
jsonschema validate setup-schema/bitbake-setup.schema.json default-registry/configurations/poky-master.conf.json
jsonschema validate setup-schema/bitbake-setup.schema.json default-registry/configurations/poky-whinlatter.conf.json
```

There are 2 outstanding types of linting errors related to the use of hyphen
in the property names and the enum currently having only one value:

  Set `properties` to identifier names that can be easily mapped to programming
  languages (matching [A-Za-z_][A-Za-z0-9_]*) (simple_properties_identifiers).

  An `enum` of a single value can be expressed as `const` (enum_to_const)

The former would require a larger discussion and potentially increasing the
version number. Updating the enum to include a new version would also resolve
the latter error.

I do not believe that the changes in this series merit increasing the version
of the schema.

Resolving these outstanding errors is not necessary for validating the
Bitbake Configuration files.

UPDATE v2: Additional testing was performed with oe-selftest.  This uses
    python3-jsonschema which is a different implementation and caught
    additional linting errors.

UPDATE v3: Tested with bitbake-selftest, oe-selftest, and bitbake quilt-native

```
    git clone https://git.openembedded.org/bitbake

    ./bitbake/bin/bitbake-setup init --non-interactive poky-master poky machine/qemux86-64 distro/poky

    . /ala-lpggp31/rwoolley/oe-selftest-testing/bitbake-builds/poky-master/build/init-build-env

    echo 'SANITY_TESTED_DISTROS = ""' >> conf/local.conf

    oe-selftest -r bblayers.BitbakeLayers
```

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
Rob Woolley (10):
      bitbake-setup.schema.json: Add title for schema
      bitbake-setup.schema.json: Add examples property
      bitbake-setup.schema.json: Use anyOf for non-disjoint subschemas
      bitbake-setup.schema.json: Remove trailing period
      layers.schema.json: Add missing schema
      layers.schema.json: Add title for subschema
      layers.schema.json: Add examples property
      layers.schema.json: Remove trailing period
      layers.schema.json: Fix typo in property name
      bitbake-setup.schema.json: Use anyOf for non-disjoint subschemas

 setup-schema/bitbake-setup.schema.json | 40 +++++++++++++++++++++++++++++++---
 setup-schema/layers.schema.json        | 29 ++++++++++++++++++++----
 2 files changed, 62 insertions(+), 7 deletions(-)
---
base-commit: 020a5ba24c7df53eacf834deb87216053ccd38db
change-id: 20260615-fix-bitbake-schema-0ae8bd18a24c

Best regards,
--  
Rob Woolley <rob.woolley@windriver.com>


