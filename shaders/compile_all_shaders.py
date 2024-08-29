import os
import sys

THIS_SCRIPT_FOLDER = os.path.abspath( os.path.dirname( os.path.realpath( __file__ ) ) )
OUTPUT_FOLDER = os.path.abspath( os.path.join( THIS_SCRIPT_FOLDER, "spirv" ) )
OUTPUT_FILENAME = "ShaderGen"
BYTECODE_PREFIX = "MERCURY_SHADER"
GLSLC_FOLDER = os.path.abspath( os.path.join( THIS_SCRIPT_FOLDER, "../../ots/vulkan/bin" ) )
JSON_FILENAME_AND_PATH = os.path.abspath( os.path.join( THIS_SCRIPT_FOLDER, "shaders.json" ) )
PATH_TO_VKN_SHADER_FOLDER = os.path.abspath( os.path.join( THIS_SCRIPT_FOLDER, "../../src/render/vkn/shader" ) )

sys.path.append( PATH_TO_VKN_SHADER_FOLDER )

import argparse
import logging
import vkn_compile_shaders

log = logging.getLogger( __name__ )

def main():
	parser = argparse.ArgumentParser( description = "Compile SPIR-V bytecode shaders." )
	parser.add_argument( "--verbose", help = "output more processing information", action = "store_true" )

	args = parser.parse_args()

	log.setLevel( logging.INFO )
	if args.verbose:
		log.setLevel( logging.DEBUG )

	try:
		shader_count = vkn_compile_shaders.compile_from_json( output_folder=OUTPUT_FOLDER,
		                                                      output_filename=OUTPUT_FILENAME,
															  bytecode_prefix=BYTECODE_PREFIX,
															  json_path_w_filename=JSON_FILENAME_AND_PATH,
															  glslc_folder=GLSLC_FOLDER,
															  shaders_root_folder=THIS_SCRIPT_FOLDER )
		log.info( "Success! {0} shaders(s) compiled.".format( shader_count ) )
		print( "Compiled {0} shaders to SPIR-V.".format( shader_count ) )

	except vkn_compile_shaders.JsonMalformedEntryException as e:
		log.error( "Malformed shader entry in JSON." )
		log.error( "Filename was {0}. {1}".format( e.filename, e.hint ) )

	except vkn_compile_shaders.JsonNotFoundException as e:
		log.error( "Could not find JSON definition file." )
		log.error( "{0} did not exist.".format( e.filename_and_path ) )

	except vkn_compile_shaders.ShaderFailedCompileException as e:
		log.error( "A shader failed to compile: {0}".format( e.filename ) )
		log.error( "Output:\n" )
		log.error( e.error_str )

	except vkn_compile_shaders.GlslcNotFoundException as e:
		log.error( "Could not find GLSLC compiler." )
		log.error( "Did not exist at: {0}".e.filename_and_path )

	except vkn_compile_shaders.ShaderFileNotFoundException as e:
		log.error( "Could not find shader file(s):" )
		for filename in e.filenames:
			log.error( filename )

	return

if __name__ == "__main__":
	main()